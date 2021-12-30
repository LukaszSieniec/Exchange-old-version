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
  final String amountMoney;

  const AmountBuyCryptocurrencyUpdated(this.amountMoney);

  @override
  List<Object> get props => [amountMoney];
}

class ConfirmedBuyCryptocurrency extends BuyCryptocurrencyEvent {
  const ConfirmedBuyCryptocurrency();

  @override
  List<Object> get props => [];
}
