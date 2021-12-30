import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

abstract class BuyCryptocurrencyState extends Equatable {
  const BuyCryptocurrencyState();

  @override
  List<Object> get props => [];
}

class BuyCryptocurrencyInitial extends BuyCryptocurrencyState {
  final CryptocurrencyResponse cryptocurrencyResponse;
  final double accountBalance, estimatedAmountCryptocurrency;
  final String amountMoney;

  const BuyCryptocurrencyInitial(
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

class BuyCryptocurrencyLoadInProgress extends BuyCryptocurrencyState {}

class BuyCryptocurrencyLoadSuccess extends BuyCryptocurrencyState {
  final String amountMoney;
  final String estimatedAmountCryptocurrency;

  const BuyCryptocurrencyLoadSuccess(
      this.amountMoney, this.estimatedAmountCryptocurrency);

  @override
  List<Object> get props => [amountMoney, estimatedAmountCryptocurrency];
}

class BuyCryptocurrencyLoadFailure extends BuyCryptocurrencyState {}

class BuyCryptocurrencySuccess extends BuyCryptocurrencyState {
  final String name;

  const BuyCryptocurrencySuccess(this.name);

  @override
  List<Object> get props => [name];
}

class BuyCryptocurrencyNotEnoughFunds extends BuyCryptocurrencyState {
  const BuyCryptocurrencyNotEnoughFunds();
}

class BuyCryptocurrencyInvalidAmount extends BuyCryptocurrencyState {
  const BuyCryptocurrencyInvalidAmount();
}
