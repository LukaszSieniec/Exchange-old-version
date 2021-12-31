import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class SellCryptocurrencyState extends Equatable {
  const SellCryptocurrencyState();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyInitial extends SellCryptocurrencyState {
  final Cryptocurrency cryptocurrency;
  final double accountBalance, estimatedAmount;
  final String amountCryptocurrency;

  final dynamic priceCryptocurrency;

  const SellCryptocurrencyInitial(
      this.cryptocurrency,
      this.accountBalance,
      this.amountCryptocurrency,
      this.estimatedAmount,
      this.priceCryptocurrency);

  @override
  List<Object> get props => [
        cryptocurrency,
        accountBalance,
        amountCryptocurrency,
        estimatedAmount,
        priceCryptocurrency
      ];
}

class SellCryptocurrencyLoadInProgress extends SellCryptocurrencyState {}

class SellCryptocurrencySuccess extends SellCryptocurrencyState {
  final Cryptocurrency cryptocurrency;

  const SellCryptocurrencySuccess(this.cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}

class SellCryptocurrencyNotEnoughCryptocurrency
    extends SellCryptocurrencyState {}

class SellCryptocurrencyInvalidAmount extends SellCryptocurrencyState {}

class SellCryptocurrencyLoadFailure extends SellCryptocurrencyState {}
