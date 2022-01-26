import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/transaction.dart';

enum SellCryptocurrencyStatus {
  initial,
  loading,
  success,
  failure,
  notEnoughCryptocurrency,
  invalidAmount
}

class SellCryptocurrencyState extends Equatable {
  final Cryptocurrency? cryptocurrency;
  final Transaction? transaction;

  final double estimatedAmountMoney;
  final String currentAmountCryptocurrency;
  final num? priceCryptocurrency;

  final SellCryptocurrencyStatus sellCryptocurrencyStatus;

  const SellCryptocurrencyState(
      {this.cryptocurrency,
      this.transaction,
      this.estimatedAmountMoney = 0,
      this.currentAmountCryptocurrency = '0',
      this.priceCryptocurrency,
      this.sellCryptocurrencyStatus = SellCryptocurrencyStatus.initial});

  SellCryptocurrencyState copyWith(
      {Cryptocurrency? cryptocurrency,
      Transaction? transaction,
      double? estimatedAmountMoney,
      String? currentAmountCryptocurrency,
      num? priceCryptocurrency,
      SellCryptocurrencyStatus? sellCryptocurrencyStatus}) {
    return SellCryptocurrencyState(
        cryptocurrency: cryptocurrency ?? this.cryptocurrency,
        transaction: transaction ?? this.transaction,
        estimatedAmountMoney: estimatedAmountMoney ?? this.estimatedAmountMoney,
        currentAmountCryptocurrency:
            currentAmountCryptocurrency ?? this.currentAmountCryptocurrency,
        priceCryptocurrency: priceCryptocurrency ?? this.priceCryptocurrency,
        sellCryptocurrencyStatus:
            sellCryptocurrencyStatus ?? this.sellCryptocurrencyStatus);
  }

  @override
  List<Object?> get props => [
        cryptocurrency,
        transaction,
        estimatedAmountMoney,
        currentAmountCryptocurrency,
        priceCryptocurrency,
        sellCryptocurrencyStatus
      ];
}
