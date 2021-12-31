import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCryptocurrencyBloc
    extends Bloc<SellCryptocurrencyEvent, SellCryptocurrencyState> {
  final CryptocurrencyRepository cryptocurrencyRepository;
  final WalletBloc walletBloc;

  SellCryptocurrencyBloc(this.cryptocurrencyRepository, this.walletBloc)
      : super(SellCryptocurrencyLoadInProgress()) {
    on<SellCryptocurrencyLoaded>(_onSellCryptocurrencyLoaded);
    on<SellCryptocurrencyAmountUpdated>(_onSellCryptocurrencyAmountUpdated);
    on<SellCryptocurrencyConfirmed>(_onSellCryptocurrencyConfirmed);
  }

  void _onSellCryptocurrencyLoaded(SellCryptocurrencyLoaded event,
      Emitter<SellCryptocurrencyState> emit) async {
    final dynamic price = await cryptocurrencyRepository.fetchPrice(event.id);

    final Cryptocurrency cryptocurrency =
        (walletBloc.state as WalletLoadSuccess)
            .cryptocurrencies
            .firstWhere((element) => element.id == event.id);

    emit(SellCryptocurrencyInitial(
        cryptocurrency, AccountBalance.readAccountBalance(), '0', 0, price));
  }

  void _onSellCryptocurrencyAmountUpdated(SellCryptocurrencyAmountUpdated event,
      Emitter<SellCryptocurrencyState> emit) {
    final SellCryptocurrencyInitial sellCryptocurrenciesInitial =
        (state as SellCryptocurrencyInitial);

    final String currentAmount = sellCryptocurrenciesInitial
        .amountCryptocurrency
        .appendNumber(event.amountCryptocurrency);

    final dynamic price = sellCryptocurrenciesInitial.priceCryptocurrency;

    final Cryptocurrency cryptocurrency =
        sellCryptocurrenciesInitial.cryptocurrency;

    final double estimatedAmount =
        double.parse((double.parse(currentAmount) * price).toStringAsFixed(5));

    emit(SellCryptocurrencyInitial(
        cryptocurrency,
        AccountBalance.readAccountBalance(),
        currentAmount,
        estimatedAmount,
        price));
  }

  void _onSellCryptocurrencyConfirmed(SellCryptocurrencyConfirmed event,
      Emitter<SellCryptocurrencyState> emit) {
    final SellCryptocurrencyInitial sellCryptocurrencyInitial =
        (state as SellCryptocurrencyInitial);

    final String currentAmount = sellCryptocurrencyInitial.amountCryptocurrency;
    final double accountBalance = sellCryptocurrencyInitial.accountBalance;
    final double estimatedAmount = sellCryptocurrencyInitial.estimatedAmount;
    final Cryptocurrency cryptocurrency =
        sellCryptocurrencyInitial.cryptocurrency;
    final dynamic price = sellCryptocurrencyInitial.priceCryptocurrency;

    if (double.parse(currentAmount) > cryptocurrency.amount) {
      emit(SellCryptocurrencyNotEnoughCryptocurrency());
      emit(SellCryptocurrencyInitial(cryptocurrency, accountBalance,
          currentAmount, estimatedAmount, price));
    } else if (currentAmount == '0') {
      emit(SellCryptocurrencyInvalidAmount());
      emit(SellCryptocurrencyInitial(cryptocurrency, accountBalance,
          currentAmount, estimatedAmount, price));
    } else {
      try {
        final double newAccountBalance = accountBalance + estimatedAmount;

        emit(SellCryptocurrencySuccess(cryptocurrency));
        emit(SellCryptocurrencyInitial(
            cryptocurrency, newAccountBalance, '0', 0, price));

        _updateCryptocurrency(cryptocurrency, double.parse(currentAmount));
        _createTransaction(cryptocurrency, estimatedAmount, price);
        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(SellCryptocurrencyLoadFailure());
      }
    }
  }

  Future<void> _updateCryptocurrency(
          Cryptocurrency cryptocurrency, double currentAmount) =>
      cryptocurrencyRepository
          .updateCryptocurrency(cryptocurrency.id, currentAmount);

  Future<void> _createTransaction(Cryptocurrency cryptocurrency,
          double estimatedAmount, double price) =>
      cryptocurrencyRepository.createTransaction(Transaction.fromCryptocurrency(
          cryptocurrency, estimatedAmount, price));

  Future<void> _saveAccountBalance(double newAccountBalance) =>
      AccountBalance.saveAccountBalance(newAccountBalance);
}
