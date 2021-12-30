import 'package:equatable/equatable.dart';

abstract class SellCryptocurrencyState extends Equatable {
  const SellCryptocurrencyState();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyInitial extends SellCryptocurrencyState {
  final double accountBalance, estimatedAmount;
  final String amount;

  const SellCryptocurrencyInitial(
      this.accountBalance, this.amount, this.estimatedAmount);

  @override
  List<Object> get props => [accountBalance, amount, estimatedAmount];
}
