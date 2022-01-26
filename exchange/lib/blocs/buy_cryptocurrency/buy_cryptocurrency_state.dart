import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/transaction.dart';

enum BuyCryptocurrencyStatus {
  initial,
  loading,
  success,
  failure,
  notEnoughFunds,
  invalidAmount
}

class BuyCryptocurrencyState extends Equatable {
  final CryptocurrencyResponse? cryptocurrencyResponse;
  final Cryptocurrency? cryptocurrency;
  final Transaction? transaction;

  final double? accountBalance;
  final double estimatedAmountCryptocurrency;
  final String currentAmountMoney;

  final BuyCryptocurrencyStatus buyCryptocurrencyStatus;

  const BuyCryptocurrencyState(
      {this.cryptocurrencyResponse,
      this.cryptocurrency,
      this.transaction,
      this.accountBalance,
      this.estimatedAmountCryptocurrency = 0,
      this.currentAmountMoney = '0',
      this.buyCryptocurrencyStatus = BuyCryptocurrencyStatus.initial});

  BuyCryptocurrencyState copyWith(
      {CryptocurrencyResponse? cryptocurrencyResponse,
      Cryptocurrency? cryptocurrency,
      Transaction? transaction,
      double? accountBalance,
      double? estimatedAmountCryptocurrency,
      String? currentAmountMoney,
      BuyCryptocurrencyStatus? buyCryptocurrencyStatus}) {
    return BuyCryptocurrencyState(
      cryptocurrencyResponse:
          cryptocurrencyResponse ?? this.cryptocurrencyResponse,
      cryptocurrency: cryptocurrency ?? this.cryptocurrency,
      transaction: transaction ?? this.transaction,
      accountBalance: accountBalance ?? this.accountBalance,
      estimatedAmountCryptocurrency:
          estimatedAmountCryptocurrency ?? this.estimatedAmountCryptocurrency,
      currentAmountMoney: currentAmountMoney ?? this.currentAmountMoney,
      buyCryptocurrencyStatus:
          buyCryptocurrencyStatus ?? this.buyCryptocurrencyStatus,
    );
  }

  @override
  List<Object?> get props => [
        cryptocurrencyResponse,
        cryptocurrency,
        transaction,
        accountBalance,
        estimatedAmountCryptocurrency,
        currentAmountMoney,
        buyCryptocurrencyStatus
      ];
}
