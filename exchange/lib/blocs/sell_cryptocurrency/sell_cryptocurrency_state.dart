import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/transaction.dart';

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
  final Transaction transaction;

  const SellCryptocurrencySuccess(this.name, this.transaction);

  @override
  List<Object> get props => [name, transaction];
}

class SellCryptocurrencyNotEnoughCryptocurrency
    extends SellCryptocurrencyState {}

class SellCryptocurrencyInvalidAmount extends SellCryptocurrencyState {}
