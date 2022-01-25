import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletEvent {
  const WalletLoaded();
}

class WalletUpdatedSale extends WalletEvent {
  final Cryptocurrency cryptocurrency;

  const WalletUpdatedSale(this.cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}

class WalletUpdatedPurchase extends WalletEvent {
  final Cryptocurrency cryptocurrency;

  const WalletUpdatedPurchase(this.cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}
