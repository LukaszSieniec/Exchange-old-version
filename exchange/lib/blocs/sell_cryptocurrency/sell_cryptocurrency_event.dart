import 'package:equatable/equatable.dart';

abstract class SellCryptocurrencyEvent extends Equatable {
  const SellCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyLoaded extends SellCryptocurrencyEvent {
  final String id;

  const SellCryptocurrencyLoaded(this.id);

  @override
  List<Object> get props => [id];
}

class SellCryptocurrencyAmountUpdated extends SellCryptocurrencyEvent {
  final String amountCryptocurrency;

  const SellCryptocurrencyAmountUpdated(this.amountCryptocurrency);

  @override
  List<Object> get props => [amountCryptocurrency];
}

class SellCryptocurrencyConfirmed extends SellCryptocurrencyEvent {}
