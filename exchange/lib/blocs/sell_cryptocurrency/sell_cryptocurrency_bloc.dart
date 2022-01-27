import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCryptocurrencyBloc
    extends Bloc<SellCryptocurrencyEvent, SellCryptocurrencyState> {
  final CryptocurrencyRepository cryptocurrencyRepository;

  SellCryptocurrencyBloc(this.cryptocurrencyRepository)
      : super(const SellCryptocurrencyState()) {
    on<SellCryptocurrencyLoaded>(_onSellCryptocurrencyLoaded);
    on<SellCryptocurrencyAmountUpdated>(_onSellCryptocurrencyAmountUpdated);
    on<SellCryptocurrencyConfirmed>(_onSellCryptocurrencyConfirmed);
  }

  void _onSellCryptocurrencyLoaded(SellCryptocurrencyLoaded event,
      Emitter<SellCryptocurrencyState> emit) async {
    emit(state.copyWith(
        sellCryptocurrencyStatus: SellCryptocurrencyStatus.loading));

    try {
      final num priceCryptocurrency =
          await cryptocurrencyRepository.fetchPrice(event.cryptocurrency.id);

      emit(state.copyWith(
          cryptocurrency: event.cryptocurrency,
          estimatedAmountMoney: 0,
          currentAmountCryptocurrency: '0',
          priceCryptocurrency: priceCryptocurrency,
          sellCryptocurrencyStatus: SellCryptocurrencyStatus.initial));
    } catch (e) {
      emit(state.copyWith(
          sellCryptocurrencyStatus: SellCryptocurrencyStatus.failure));
    }
  }

  void _onSellCryptocurrencyAmountUpdated(SellCryptocurrencyAmountUpdated event,
      Emitter<SellCryptocurrencyState> emit) {
    final String currentAmountCryptocurrency = state.currentAmountCryptocurrency
        .appendAmountCryptocurrency(event.selectedLabel);

    final double estimatedAmountMoney =
        (double.parse(currentAmountCryptocurrency) * state.priceCryptocurrency!)
            .setAmountMoneyPrecision();

    emit(state.copyWith(
        estimatedAmountMoney: estimatedAmountMoney,
        currentAmountCryptocurrency: currentAmountCryptocurrency));
  }

  void _onSellCryptocurrencyConfirmed(SellCryptocurrencyConfirmed event,
      Emitter<SellCryptocurrencyState> emit) {
    if (double.parse(state.currentAmountCryptocurrency) >
        state.cryptocurrency!.amount) {
      emit(state.copyWith(
          sellCryptocurrencyStatus:
              SellCryptocurrencyStatus.notEnoughCryptocurrency));
      emit(state.copyWith(
          sellCryptocurrencyStatus: SellCryptocurrencyStatus.initial));
    } else if (state.currentAmountCryptocurrency == '0') {
      emit(state.copyWith(
          sellCryptocurrencyStatus: SellCryptocurrencyStatus.invalidAmount));
      emit(state.copyWith(
          sellCryptocurrencyStatus: SellCryptocurrencyStatus.initial));
    } else {
      try {
        final double newAccountBalance =
            (AccountBalance.readAccountBalance() + state.estimatedAmountMoney)
                .setAmountMoneyPrecision();
        final Transaction transaction = Transaction.fromCryptocurrency(
            state.cryptocurrency!,
            state.estimatedAmountMoney,
            state.priceCryptocurrency);
        final Cryptocurrency newCryprocurrency = state.cryptocurrency!.copyWith(
            amount: state.cryptocurrency!.amount -
                double.parse(state.currentAmountCryptocurrency));

        emit(state.copyWith(
            cryptocurrency: newCryprocurrency,
            transaction: transaction,
            sellCryptocurrencyStatus: SellCryptocurrencyStatus.success));

        emit(state.copyWith(
            estimatedAmountMoney: 0,
            currentAmountCryptocurrency: '0',
            sellCryptocurrencyStatus: SellCryptocurrencyStatus.initial));

        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(state.copyWith(
            sellCryptocurrencyStatus: SellCryptocurrencyStatus.failure));
      }
    }
  }

  Future<void> _saveAccountBalance(double newAccountBalance) =>
      AccountBalance.saveAccountBalance(newAccountBalance);
}
