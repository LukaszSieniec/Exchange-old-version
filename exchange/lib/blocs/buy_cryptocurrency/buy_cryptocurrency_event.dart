import 'package:equatable/equatable.dart';

abstract class BuyCryptocurrencyEvent extends Equatable {
  const BuyCryptocurrencyEvent();

  @override
  List<Object> get props => [];
}

class BuyCryptocurrencyLoaded extends BuyCryptocurrencyEvent {
  final String id;

  const BuyCryptocurrencyLoaded(this.id);

  @override
  List<Object> get props => [id];
}

class BuyCryptocurrencyCurrentAmountMoneyUpdated
    extends BuyCryptocurrencyEvent {
  final String selectedLabel;

  const BuyCryptocurrencyCurrentAmountMoneyUpdated(this.selectedLabel);

  @override
  List<Object> get props => [selectedLabel];
}

class BuyCryptocurrencyConfirmed extends BuyCryptocurrencyEvent {
  const BuyCryptocurrencyConfirmed();
}
