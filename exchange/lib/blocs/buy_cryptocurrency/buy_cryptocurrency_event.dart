import 'package:equatable/equatable.dart';

abstract class BuyCryptocurrenciesEvent extends Equatable {
  const BuyCryptocurrenciesEvent();
}

class AmountCryptocurrencyUpdated extends BuyCryptocurrenciesEvent {
  final String number;

  const AmountCryptocurrencyUpdated(this.number);

  @override
  List<Object?> get props => [number];
}
