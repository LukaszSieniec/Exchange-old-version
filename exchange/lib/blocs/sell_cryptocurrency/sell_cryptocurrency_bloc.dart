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
      : super(SellCryptocurrencyLoadInProgress()) {
    on<SellCryptocurrencyLoaded>(_onSellCryptocurrencyLoaded);
    on<SellCryptocurrencyAmountUpdated>(_onSellCryptocurrencyAmountUpdated);
    on<SellCryptocurrencyConfirmed>(_onSellCryptocurrencyConfirmed);
  }

  void _onSellCryptocurrencyLoaded(SellCryptocurrencyLoaded event,
      Emitter<SellCryptocurrencyState> emit) async {
    emit(SellCryptocurrencyLoadInProgress());
    final num price =
        await cryptocurrencyRepository.fetchPrice(event.cryptocurrency.id);
    print('Price: $price');

    emit(SellCryptocurrencyInitial(event.cryptocurrency, '0', 0, price));
  }

  void _onSellCryptocurrencyAmountUpdated(SellCryptocurrencyAmountUpdated event,
      Emitter<SellCryptocurrencyState> emit) {
    final SellCryptocurrencyInitial sellCryptocurrenciesInitial =
        (state as SellCryptocurrencyInitial);

    final String currentAmount = sellCryptocurrenciesInitial
        .amountCryptocurrency
        .appendAmountCryptocurrency(event.amountCryptocurrency);

    final dynamic price = sellCryptocurrenciesInitial.priceCryptocurrency;

    final Cryptocurrency cryptocurrency =
        sellCryptocurrenciesInitial.cryptocurrency;

    final double estimatedAmount =
        (double.parse(currentAmount) * price).setAmountMoneyPrecision();

    emit(SellCryptocurrencyInitial(
        cryptocurrency, currentAmount, estimatedAmount, price));
  }

  void _onSellCryptocurrencyConfirmed(SellCryptocurrencyConfirmed event,
      Emitter<SellCryptocurrencyState> emit) {
    final SellCryptocurrencyInitial sellCryptocurrencyInitial =
        (state as SellCryptocurrencyInitial);

    final String currentAmount = sellCryptocurrencyInitial.amountCryptocurrency;
    final double estimatedAmount = sellCryptocurrencyInitial.estimatedAmount;
    final Cryptocurrency cryptocurrency =
        sellCryptocurrencyInitial.cryptocurrency;
    final num price = sellCryptocurrencyInitial.priceCryptocurrency;

    if (double.parse(currentAmount) > cryptocurrency.amount) {
      emit(SellCryptocurrencyNotEnoughCryptocurrency());
      emit(SellCryptocurrencyInitial(
          cryptocurrency, currentAmount, estimatedAmount, price));
    } else if (currentAmount == '0') {
      emit(SellCryptocurrencyInvalidAmount());
      emit(SellCryptocurrencyInitial(
          cryptocurrency, currentAmount, estimatedAmount, price));
    } else {
      try {
        final double newAccountBalance =
            (AccountBalance.readAccountBalance() + estimatedAmount).setAmountMoneyPrecision();
        final Transaction transaction = Transaction.fromCryptocurrency(
            cryptocurrency, estimatedAmount, price);
        final Cryptocurrency newCryprocurrency = cryptocurrency.copyWith(
            amount: cryptocurrency.amount - double.parse(currentAmount));

        emit(SellCryptocurrencySuccess(newCryprocurrency, transaction));
        emit(SellCryptocurrencyInitial(newCryprocurrency, '0', 0, price));

        _updateCryptocurrency(cryptocurrency, double.parse(currentAmount));
        _createTransaction(transaction);
        _saveAccountBalance(newAccountBalance);
      } on Exception {
        emit(SellCryptocurrencyLoadFailure());
      }
    }
  }

  Future<void> _updateCryptocurrency(
          Cryptocurrency cryptocurrency, double currentAmount) =>
      cryptocurrencyRepository.updateCryptocurrency(
          cryptocurrency.id, currentAmount);

  Future<void> _createTransaction(Transaction transaction) =>
      cryptocurrencyRepository.createTransaction(transaction);

  Future<void> _saveAccountBalance(double newAccountBalance) =>
      AccountBalance.saveAccountBalance(newAccountBalance);
}
