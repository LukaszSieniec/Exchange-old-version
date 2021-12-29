import 'package:equatable/equatable.dart';

abstract class SellCryptocurrencyEvent extends Equatable {
  const SellCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class AmountCryptocurrencyUpdated extends SellCryptocurrencyEvent {
  final String number;

  const AmountCryptocurrencyUpdated(this.number);

  @override
  List<Object> get props => [number];
}

class ConfirmedSellCryptocurrency extends SellCryptocurrencyEvent {
  const ConfirmedSellCryptocurrency();

  @override
  List<Object> get props => [];
}
