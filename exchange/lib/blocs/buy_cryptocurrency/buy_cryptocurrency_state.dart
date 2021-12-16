import 'package:equatable/equatable.dart';

abstract class BuyCryptocurrenciesState extends Equatable {
  final String amount;
  final String estimatedQuantity;

  const BuyCryptocurrenciesState(this.amount, this.estimatedQuantity);
}

class BuyCryptocurrenciesInitial extends BuyCryptocurrenciesState {
  const BuyCryptocurrenciesInitial(
      final String amount, final String estimatedQuantity)
      : super(amount, estimatedQuantity);

  @override
  List<Object> get props => throw UnimplementedError();
}

class BuyCryptocurrenciesError extends BuyCryptocurrenciesState {
  const BuyCryptocurrenciesError(String amount, String estimatedQuantity)
      : super(amount, estimatedQuantity);

  @override
  List<Object> get props => throw UnimplementedError();
}
