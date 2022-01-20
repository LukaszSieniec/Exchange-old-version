import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletEvent {}

class WalletUpdated extends WalletEvent {
  final Cryptocurrency cryptocurrency;

  const WalletUpdated(this.cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}
