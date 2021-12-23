import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

abstract class MarketChartEvent extends Equatable {
  final CryptocurrencyResponse cryptocurrency;

  const MarketChartEvent(this.cryptocurrency);
}

class MarketChartLoaded extends MarketChartEvent {
  const MarketChartLoaded(final CryptocurrencyResponse cryptocurrency) : super(cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}

class MarketChartUpdated extends MarketChartEvent {
  final int index;

  const MarketChartUpdated(final CryptocurrencyResponse cryptocurrency, this.index) : super(cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency, index];
}
