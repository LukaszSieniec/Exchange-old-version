import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

abstract class BuyCryptocurrenciesState extends Equatable {
  const BuyCryptocurrenciesState();

  @override
  List<Object> get props => [];
}

class BuyCryptocurrenciesInitial extends BuyCryptocurrenciesState {
  final CryptocurrencyResponse cryptocurrencyResponse;
  final double accountBalance, estimatedAmountCryptocurrency;
  final String amountMoney;

  const BuyCryptocurrenciesInitial(
      this.cryptocurrencyResponse,
      this.accountBalance,
      this.amountMoney,
      this.estimatedAmountCryptocurrency);

  @override
  List<Object> get props => [
        cryptocurrencyResponse,
        accountBalance,
        amountMoney,
        estimatedAmountCryptocurrency
      ];
}

class BuyCryptocurrenciesLoadInProgress extends BuyCryptocurrenciesState {}

class BuyCryptocurrenciesLoadSuccess extends BuyCryptocurrenciesState {
  final String amountMoney;
  final String estimatedAmountCryptocurrency;

  const BuyCryptocurrenciesLoadSuccess(
      this.amountMoney, this.estimatedAmountCryptocurrency);

  @override
  List<Object> get props => [amountMoney, estimatedAmountCryptocurrency];
}

class BuyCryptocurrenciesLoadFailure extends BuyCryptocurrenciesState {}

class BuyCryptocurrencySuccess extends BuyCryptocurrenciesState {
  final String name;

  const BuyCryptocurrencySuccess(this.name);

  @override
  List<Object> get props => [name];
}

class BuyCryptocurrenciesNotEnoughFunds extends BuyCryptocurrenciesState {
  const BuyCryptocurrenciesNotEnoughFunds();
}

class BuyCryptocurrenciesInvalidAmount extends BuyCryptocurrenciesState {
  const BuyCryptocurrenciesInvalidAmount();
}
