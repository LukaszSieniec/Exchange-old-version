import 'package:equatable/equatable.dart';

abstract class BuyCryptocurrenciesState extends Equatable {
  const BuyCryptocurrenciesState();
}

class BuyCryptocurrenciesInitial extends BuyCryptocurrenciesState {
  final double accountBalance, estimatedQuantity;
  final String amount;

  const BuyCryptocurrenciesInitial(this.accountBalance, this.amount, this.estimatedQuantity);

  @override
  List<Object> get props => [accountBalance, amount, estimatedQuantity];
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
