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

class BuyCryptocurrencyAmountUpdated extends BuyCryptocurrencyEvent {
  final String amountMoney;

  const BuyCryptocurrencyAmountUpdated(this.amountMoney);

  @override
  List<Object> get props => [amountMoney];
}

class BuyCryptocurrencyConfirmed extends BuyCryptocurrencyEvent {
  const BuyCryptocurrencyConfirmed();

  @override
  List<Object> get props => [];
}
