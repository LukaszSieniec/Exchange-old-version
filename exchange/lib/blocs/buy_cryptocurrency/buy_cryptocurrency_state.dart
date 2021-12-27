import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

abstract class BuyCryptocurrenciesState extends Equatable {
  const BuyCryptocurrenciesState();

  @override
  List<Object> get props => [];
}

class BuyCryptocurrenciesInitial extends BuyCryptocurrenciesState {
  final CryptocurrencyResponse cryptocurrencyResponse;
  final double accountBalance, estimatedAmount;
  final String amount;

  const BuyCryptocurrenciesInitial(this.cryptocurrencyResponse,
      this.accountBalance, this.amount, this.estimatedAmount);

  @override
  List<Object> get props =>
      [cryptocurrencyResponse, accountBalance, amount, estimatedAmount];
}

class BuyCryptocurrenciesLoadInProgress extends BuyCryptocurrenciesState {}

class BuyCryptocurrenciesLoadSuccess extends BuyCryptocurrenciesState {
  final String amount;
  final String estimatedQuantity;

  const BuyCryptocurrenciesLoadSuccess(this.amount, this.estimatedQuantity);

  @override
  List<Object> get props => [amount, estimatedQuantity];
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
