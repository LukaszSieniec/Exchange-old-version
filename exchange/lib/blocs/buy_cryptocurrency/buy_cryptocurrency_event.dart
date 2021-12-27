import 'package:equatable/equatable.dart';

abstract class BuyCryptocurrenciesEvent extends Equatable {
  const BuyCryptocurrenciesEvent();
}

class BuyCryptocurrenciesLoaded extends BuyCryptocurrenciesEvent {
  final String id;

  const BuyCryptocurrenciesLoaded(this.id);

  @override
  List<Object> get props => [id];
}

class AmountCryptocurrencyUpdated extends BuyCryptocurrenciesEvent {
  final String number;

  const AmountCryptocurrencyUpdated(this.number);

  @override
  List<Object> get props => [number];
}

class ConfirmedBuyCryptocurrency extends BuyCryptocurrenciesEvent {
  const ConfirmedBuyCryptocurrency();

  @override
  List<Object> get props => [];
}
