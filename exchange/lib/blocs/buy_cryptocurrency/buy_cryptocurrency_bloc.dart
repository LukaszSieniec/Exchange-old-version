import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
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
    final CryptocurrencyResponse cryptocurrency = cryptocurrenciesBloc
        .state.cryptocurrencies
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

    final double estimatedAmount =
        (double.parse(currentAmount) / cryptocurrencyResponse.currentPrice)
            .setAmountCryptocurrencyPrecision();

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
      emit(BuyCryptocurrencyNotEnoughFunds());
      emit(BuyCryptocurrencyInitial(
          cryptocurrency, accountBalance, currentAmount, estimatedAmount));
    } else if (currentAmount == '0') {
      emit(BuyCryptocurrencyInvalidAmount());
      emit(BuyCryptocurrencyInitial(
          cryptocurrency, accountBalance, currentAmount, estimatedAmount));
    } else {
      emit(BuyCryptocurrencyLoadInProgress());
      try {
        final double newAccountBalance =
            (accountBalance - (double.parse(currentAmount)))
                .setAmountMoneyPrecision();

        final Cryptocurrency purchasedCryptocurrency =
            Cryptocurrency.fromCryptocurrencyResponse(
                cryptocurrency, estimatedAmount);

        final Transaction transaction = Transaction.fromCryptocurrencyResponse(
            cryptocurrency, double.parse(currentAmount));

        emit(BuyCryptocurrencySuccess(purchasedCryptocurrency, transaction));
        emit(BuyCryptocurrencyInitial(
            cryptocurrency, newAccountBalance, '0', 0));

        _createCryptocurrency(purchasedCryptocurrency);
        _createTransaction(transaction);
        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(BuyCryptocurrencyLoadFailure());
      }
    }
  }

  Future<void> _createCryptocurrency(Cryptocurrency cryptocurrency) =>
      cryptocurrencyRepository.createOrUpdateCryptocurrency(cryptocurrency);

  Future<void> _createTransaction(Transaction transaction) =>
      cryptocurrencyRepository.createTransaction(transaction);

  Future<void> _saveAccountBalance(double newAccountBalance) =>
      AccountBalance.saveAccountBalance(newAccountBalance);
}
