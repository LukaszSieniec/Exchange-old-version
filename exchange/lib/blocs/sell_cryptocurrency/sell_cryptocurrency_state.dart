import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class SellCryptocurrencyState extends Equatable {
  const SellCryptocurrencyState();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyInitial extends SellCryptocurrencyState {
  final Cryptocurrency cryptocurrency;
  final double accountBalance, estimatedAmount, priceCryptocurrency;
  final String amountCryptocurrency;

  const SellCryptocurrencyInitial(
      this.cryptocurrency,
      this.accountBalance,
      this.amountCryptocurrency,
      this.estimatedAmount,
      this.priceCryptocurrency);

  @override
  List<Object> get props =>
      [cryptocurrency, accountBalance, amountCryptocurrency, estimatedAmount];
}

class SellCryptocurrencyLoadInProgress extends SellCryptocurrencyState {}
