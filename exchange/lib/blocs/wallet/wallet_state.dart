import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

enum WalletStatus { initial, loading, success, failure }

class WalletState extends Equatable {
  final List<Cryptocurrency> cryptocurrencies;
  final double? accountBalance;

  final WalletStatus walletStatus;

  const WalletState(
      {this.cryptocurrencies = const [],
      this.accountBalance,
      this.walletStatus = WalletStatus.initial});

  WalletState copyWith(
      {List<Cryptocurrency>? cryptocurrencies,
      double? accountBalance,
      WalletStatus? walletStatus}) {
    return WalletState(
        cryptocurrencies: cryptocurrencies ?? this.cryptocurrencies,
        accountBalance: accountBalance ?? this.accountBalance,
        walletStatus: walletStatus ?? this.walletStatus);
  }

  @override
  List<Object?> get props => [cryptocurrencies, accountBalance, walletStatus];
}
