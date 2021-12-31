import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class SellCryptocurrencyState extends Equatable {
  const SellCryptocurrencyState();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyInitial extends SellCryptocurrencyState {
  final Cryptocurrency cryptocurrency;
  final double estimatedAmount;
  final String amountCryptocurrency;

  final dynamic priceCryptocurrency;

  const SellCryptocurrencyInitial(
      this.cryptocurrency,
      this.amountCryptocurrency,
      this.estimatedAmount,
      this.priceCryptocurrency);

  @override
  List<Object> get props => [
        cryptocurrency,
        amountCryptocurrency,
        estimatedAmount,
        priceCryptocurrency
      ];
}

class SellCryptocurrencyLoadInProgress extends SellCryptocurrencyState {}

class SellCryptocurrencyLoadFailure extends SellCryptocurrencyState {}

class SellCryptocurrencySuccess extends SellCryptocurrencyState {
  final String name;

  const SellCryptocurrencySuccess(this.name);

  @override
  List<Object> get props => [name];
}

class SellCryptocurrencyNotEnoughCryptocurrency
    extends SellCryptocurrencyState {}

class SellCryptocurrencyInvalidAmount extends SellCryptocurrencyState {}
