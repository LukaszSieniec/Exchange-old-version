import 'package:equatable/equatable.dart';

abstract class SellCryptocurrencyEvent extends Equatable {
  const SellCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class AmountSellCryptocurrencyUpdated extends SellCryptocurrencyEvent {
  final String number;

  const AmountSellCryptocurrencyUpdated(this.number);

  @override
  List<Object> get props => [number];
}

class ConfirmedSellCryptocurrency extends SellCryptocurrencyEvent {
  const ConfirmedSellCryptocurrency();

  @override
  List<Object> get props => [];
}
