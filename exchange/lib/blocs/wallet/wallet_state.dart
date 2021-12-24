import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletLoadInProgress extends WalletState {}

class WalletLoadSuccess extends WalletState {
  final double accountBalance;
  final List<Cryptocurrency> cryptocurrencies;

  const WalletLoadSuccess(this.accountBalance,
      [this.cryptocurrencies = const []]);

  @override
  List<Object> get props => [cryptocurrencies];
}

class WalletLoadFailure extends WalletState {}
