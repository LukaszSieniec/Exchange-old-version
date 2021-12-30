import 'package:equatable/equatable.dart';

abstract class BuyCryptocurrencyEvent extends Equatable {
  const BuyCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class BuyCryptocurrencyLoaded extends BuyCryptocurrencyEvent {
  final String id;

  const BuyCryptocurrencyLoaded(this.id);

  @override
  List<Object> get props => [id];
}

class AmountBuyCryptocurrencyUpdated extends BuyCryptocurrencyEvent {
  final String number;

  const AmountBuyCryptocurrencyUpdated(this.number);

  @override
  List<Object> get props => [number];
}

class ConfirmedBuyCryptocurrency extends BuyCryptocurrencyEvent {
  const ConfirmedBuyCryptocurrency();

  @override
  List<Object> get props => [];
}
