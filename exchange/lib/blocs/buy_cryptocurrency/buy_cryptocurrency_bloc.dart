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

class BuyCryptocurrenciesBloc
    extends Bloc<BuyCryptocurrencyEvent, BuyCryptocurrenciesState> {
  CryptocurrenciesBloc cryptocurrenciesBloc;
  CryptocurrencyRepository cryptocurrencyRepository;

  BuyCryptocurrenciesBloc(
      this.cryptocurrenciesBloc, this.cryptocurrencyRepository)
      : super(BuyCryptocurrenciesLoadInProgress()) {
    on<BuyCryptocurrencyLoaded>(_onLoaded);
    on<AmountBuyCryptocurrencyUpdated>(_onAmountCryptocurrencyUpdated);
    on<ConfirmedBuyCryptocurrency>(_onConfirmedCryptocurrency);
  }

  Future<void> _onLoaded(BuyCryptocurrencyLoaded event,
      Emitter<BuyCryptocurrenciesState> emit) async {
    final CryptocurrencyResponse cryptocurrency =
        (cryptocurrenciesBloc.state as CryptocurrenciesLoadSuccess)
            .cryptocurrencies
            .firstWhere((element) => element.id == event.id);

    emit(BuyCryptocurrenciesInitial(
        cryptocurrency, AccountBalance.readAccountBalance(), '0', 0));
  }

  Future<void> _onAmountCryptocurrencyUpdated(
      AmountBuyCryptocurrencyUpdated event,
      Emitter<BuyCryptocurrenciesState> emit) async {
    final String currentAmount =
        (state as BuyCryptocurrenciesInitial).amount.appendNumber(event.number);

    final CryptocurrencyResponse cryptocurrencyResponse =
        (state as BuyCryptocurrenciesInitial).cryptocurrencyResponse;

    final double estimatedQuantity = double.parse(
        (double.parse(currentAmount) / cryptocurrencyResponse.currentPrice)
            .toStringAsFixed(5));

    emit(BuyCryptocurrenciesInitial(cryptocurrencyResponse,
        AccountBalance.readAccountBalance(), currentAmount, estimatedQuantity));
  }

  Future<void> _onConfirmedCryptocurrency(ConfirmedBuyCryptocurrency event,
      Emitter<BuyCryptocurrenciesState> emit) async {
    final BuyCryptocurrenciesInitial buyCryptocurrenciesInitial =
        (state as BuyCryptocurrenciesInitial);

    final String currentAmount = buyCryptocurrenciesInitial.amount;
    final double accountBalance = buyCryptocurrenciesInitial.accountBalance;
    final double estimatedAmount = buyCryptocurrenciesInitial.estimatedAmount;
    final CryptocurrencyResponse cryptocurrency =
        buyCryptocurrenciesInitial.cryptocurrencyResponse;

    if (double.parse(currentAmount) > accountBalance) {
      emit(const BuyCryptocurrenciesNotEnoughFunds());
      emit(BuyCryptocurrenciesInitial(
          cryptocurrency, accountBalance, currentAmount, estimatedAmount));
    } else if (currentAmount == '0') {
      emit(const BuyCryptocurrenciesInvalidAmount());
      emit(BuyCryptocurrenciesInitial(
          cryptocurrency, accountBalance, currentAmount, estimatedAmount));
    } else {
      emit(BuyCryptocurrenciesLoadInProgress());
      try {
        final double newAccountBalance =
            accountBalance - double.parse(currentAmount);

        emit(BuyCryptocurrencySuccess(cryptocurrency.name));
        emit(BuyCryptocurrenciesInitial(
            cryptocurrency, newAccountBalance, '0', 0));

        _createOrUpdateCryptocurrency(cryptocurrency, estimatedAmount);
        _createTransaction(cryptocurrency, double.parse(currentAmount));
        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(BuyCryptocurrenciesLoadFailure());
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
