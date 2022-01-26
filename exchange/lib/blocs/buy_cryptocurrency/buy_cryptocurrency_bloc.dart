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
      : super(const BuyCryptocurrencyState()) {
    on<BuyCryptocurrencyLoaded>(_onBuyCryptocurrencyLoaded);
    on<BuyCryptocurrencyCurrentAmountMoneyUpdated>(
        _onBuyCryptocurrencyCurrentAmountMoneyUpdated);
    on<BuyCryptocurrencyConfirmed>(_onBuyCryptocurrencyConfirmed);
  }

  Future<void> _onBuyCryptocurrencyLoaded(BuyCryptocurrencyLoaded event,
      Emitter<BuyCryptocurrencyState> emit) async {
    final CryptocurrencyResponse cryptocurrency = cryptocurrenciesBloc
        .state.cryptocurrencies
        .firstWhere((element) => element.id == event.id);

    emit(state.copyWith(
        cryptocurrencyResponse: cryptocurrency,
        accountBalance: AccountBalance.readAccountBalance()));
  }

  Future<void> _onBuyCryptocurrencyCurrentAmountMoneyUpdated(
      BuyCryptocurrencyCurrentAmountMoneyUpdated event,
      Emitter<BuyCryptocurrencyState> emit) async {
    final String currentAmountMoney =
        state.currentAmountMoney.appendAmountMoney(event.selectedLabel);

    final double estimatedAmountCryptocurrency =
        (double.parse(currentAmountMoney) /
                state.cryptocurrencyResponse!.currentPrice)
            .setAmountCryptocurrencyPrecision();

    emit(state.copyWith(
        estimatedAmountCryptocurrency: estimatedAmountCryptocurrency,
        currentAmountMoney: currentAmountMoney));
  }

  Future<void> _onBuyCryptocurrencyConfirmed(BuyCryptocurrencyConfirmed event,
      Emitter<BuyCryptocurrencyState> emit) async {
    if (double.parse(state.currentAmountMoney) > state.accountBalance!) {
      emit(state.copyWith(
          buyCryptocurrencyStatus: BuyCryptocurrencyStatus.notEnoughFunds));
      emit(state.copyWith(
          buyCryptocurrencyStatus: BuyCryptocurrencyStatus.initial));
    } else if (state.currentAmountMoney == '0') {
      emit(state.copyWith(
          buyCryptocurrencyStatus: BuyCryptocurrencyStatus.invalidAmount));
      emit(state.copyWith(
          buyCryptocurrencyStatus: BuyCryptocurrencyStatus.initial));
    } else {
      emit(state.copyWith(
          buyCryptocurrencyStatus: BuyCryptocurrencyStatus.loading));
      try {
        final double newAccountBalance =
            (state.accountBalance! - (double.parse(state.currentAmountMoney)))
                .setAmountMoneyPrecision();

        final Cryptocurrency purchasedCryptocurrency =
            Cryptocurrency.fromCryptocurrencyResponse(
                state.cryptocurrencyResponse!,
                state.estimatedAmountCryptocurrency);

        final Transaction transaction = Transaction.fromCryptocurrencyResponse(
            state.cryptocurrencyResponse!,
            double.parse(state.currentAmountMoney));

        emit(state.copyWith(
            cryptocurrency: purchasedCryptocurrency,
            transaction: transaction,
            buyCryptocurrencyStatus: BuyCryptocurrencyStatus.success));
        emit(state.copyWith(
            accountBalance: newAccountBalance,
            estimatedAmountCryptocurrency: 0,
            currentAmountMoney: '0',
            buyCryptocurrencyStatus: BuyCryptocurrencyStatus.initial));

        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(state.copyWith(
            buyCryptocurrencyStatus: BuyCryptocurrencyStatus.failure));
      }
    }
  }

  Future<void> _saveAccountBalance(double newAccountBalance) =>
      AccountBalance.saveAccountBalance(newAccountBalance);
}
