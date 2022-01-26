import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class SellCryptocurrencyEvent extends Equatable {
  const SellCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class SellCryptocurrencyLoaded extends SellCryptocurrencyEvent {
  final Cryptocurrency cryptocurrency;

  const SellCryptocurrencyLoaded(this.cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}

class SellCryptocurrencyAmountUpdated extends SellCryptocurrencyEvent {
  final String selectedLabel;

  const SellCryptocurrencyAmountUpdated(this.selectedLabel);

  @override
  List<Object> get props => [selectedLabel];
}

class SellCryptocurrencyConfirmed extends SellCryptocurrencyEvent {
  const SellCryptocurrencyConfirmed();
}
