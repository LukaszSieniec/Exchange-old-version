import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

abstract class BuyCryptocurrenciesState extends Equatable {
  const BuyCryptocurrenciesState();
}

class BuyCryptocurrenciesInitial extends BuyCryptocurrenciesState {
  final CryptocurrencyResponse cryptocurrencyResponse;
  final double accountBalance, estimatedAmount;
  final String amount;

  const BuyCryptocurrenciesInitial(this.cryptocurrencyResponse,
      this.accountBalance, this.amount, this.estimatedAmount);

  @override
  List<Object> get props => [accountBalance, amount, estimatedAmount];
}

class BuyCryptocurrenciesLoadInProgress extends BuyCryptocurrenciesState {
  @override
  List<Object> get props => [];
}

class BuyCryptocurrenciesLoadSuccess extends BuyCryptocurrenciesState {
  final String amount;
  final String estimatedQuantity;

  const BuyCryptocurrenciesLoadSuccess(this.amount, this.estimatedQuantity);

  @override
  List<Object> get props => [amount, estimatedQuantity];
}

class BuyCryptocurrenciesLoadFailure extends BuyCryptocurrenciesState {
  @override
  List<Object> get props => [];
}

class BuyCryptocurrencySuccess extends BuyCryptocurrenciesState {
  final String name;

  const BuyCryptocurrencySuccess(this.name);

  @override
  List<Object> get props => [name];
}
