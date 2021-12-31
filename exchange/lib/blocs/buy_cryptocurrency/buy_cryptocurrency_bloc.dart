import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buy_cryptocurrency_event.dart';
import 'buy_cryptocurrency_state.dart';

class BuyCryptocurrencyBloc
    extends Bloc<BuyCryptocurrencyEvent, BuyCryptocurrencyState> {
  CryptocurrenciesBloc cryptocurrenciesBloc;
  CryptocurrencyRepository cryptocurrencyRepository;

  BuyCryptocurrencyBloc(
      this.cryptocurrenciesBloc, this.cryptocurrencyRepository)
      : super(BuyCryptocurrencyLoadInProgress()) {
    on<BuyCryptocurrencyLoaded>(_onBuyCryptocurrencyLoaded);
    on<BuyCryptocurrencyAmountUpdated>(_onBuyCryptocurrencyAmountUpdated);
    on<BuyCryptocurrencyConfirmed>(_onBuyCryptocurrencyConfirmed);
  }

  Future<void> _onBuyCryptocurrencyLoaded(BuyCryptocurrencyLoaded event,
      Emitter<BuyCryptocurrencyState> emit) async {
    final CryptocurrencyResponse cryptocurrency =
        (cryptocurrenciesBloc.state as CryptocurrenciesLoadSuccess)
            .cryptocurrencies
            .firstWhere((element) => element.id == event.id);

    emit(BuyCryptocurrencyInitial(
        cryptocurrency, AccountBalance.readAccountBalance(), '0', 0));
  }

  Future<void> _onBuyCryptocurrencyAmountUpdated(
      BuyCryptocurrencyAmountUpdated event,
      Emitter<BuyCryptocurrencyState> emit) async {
    final String currentAmount = (state as BuyCryptocurrencyInitial)
        .amountMoney
        .appendAmountMoney(event.amountMoney);

    final CryptocurrencyResponse cryptocurrencyResponse =
        (state as BuyCryptocurrencyInitial).cryptocurrencyResponse;

    final double estimatedAmount = double.parse(
        (double.parse(currentAmount) / cryptocurrencyResponse.currentPrice)
            .toStringAsFixed(5));

    emit(BuyCryptocurrencyInitial(cryptocurrencyResponse,
        AccountBalance.readAccountBalance(), currentAmount, estimatedAmount));
  }

  Future<void> _onBuyCryptocurrencyConfirmed(BuyCryptocurrencyConfirmed event,
      Emitter<BuyCryptocurrencyState> emit) async {
    final BuyCryptocurrencyInitial buyCryptocurrencyInitial =
        (state as BuyCryptocurrencyInitial);

    final String currentAmount = buyCryptocurrencyInitial.amountMoney;
    final double accountBalance = buyCryptocurrencyInitial.accountBalance;
    final double estimatedAmount =
        buyCryptocurrencyInitial.estimatedAmountCryptocurrency;
    final CryptocurrencyResponse cryptocurrency =
        buyCryptocurrencyInitial.cryptocurrencyResponse;

    if (double.parse(currentAmount) > accountBalance) {
      emit(const BuyCryptocurrencyNotEnoughFunds());
      emit(BuyCryptocurrencyInitial(
          cryptocurrency, accountBalance, currentAmount, estimatedAmount));
    } else if (currentAmount == '0') {
      emit(const BuyCryptocurrencyInvalidAmount());
      emit(BuyCryptocurrencyInitial(
          cryptocurrency, accountBalance, currentAmount, estimatedAmount));
    } else {
      emit(BuyCryptocurrencyLoadInProgress());
      try {
        final double newAccountBalance =
            accountBalance - double.parse(currentAmount);

        emit(BuyCryptocurrencySuccess(cryptocurrency.name));
        emit(BuyCryptocurrencyInitial(
            cryptocurrency, newAccountBalance, '0', 0));

        _createOrUpdateCryptocurrency(cryptocurrency, estimatedAmount);
        _createTransaction(cryptocurrency, double.parse(currentAmount));
        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(BuyCryptocurrencyLoadFailure());
      }
    }
  }

  Future<void> _createOrUpdateCryptocurrency(
          CryptocurrencyResponse cryptocurrency, double estimatedAmount) =>
      cryptocurrencyRepository.createOrUpdateCryptocurrency(
          Cryptocurrency.fromCryptocurrencyResponse(
              cryptocurrency, estimatedAmount));

  Future<void> _createTransaction(
          CryptocurrencyResponse cryptocurrency, double amount) =>
      cryptocurrencyRepository.createTransaction(
          Transaction.fromCryptocurrencyResponse(cryptocurrency, amount));

  Future<void> _saveAccountBalance(double newAccountBalance) =>
      AccountBalance.saveAccountBalance(newAccountBalance);
}
