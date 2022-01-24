import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class SellCryptocurrencyEvent extends Equatable {
  const SellCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyLoaded extends SellCryptocurrencyEvent {
  final Cryptocurrency cryptocurrency;

  const SellCryptocurrencyLoaded(this.cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}

class SellCryptocurrencyAmountUpdated extends SellCryptocurrencyEvent {
  final String amountCryptocurrency;

  const SellCryptocurrencyAmountUpdated(this.amountCryptocurrency);

  @override
  List<Object> get props => [amountCryptocurrency];
}

class SellCryptocurrencyConfirmed extends SellCryptocurrencyEvent {}
