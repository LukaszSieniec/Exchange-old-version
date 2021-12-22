import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class MarketChartEvent extends Equatable {
  final Cryptocurrency cryptocurrency;

  const MarketChartEvent(this.cryptocurrency);
}

class MarketChartLoaded extends MarketChartEvent {
  const MarketChartLoaded(final Cryptocurrency cryptocurrency) : super(cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency];
}

class MarketChartUpdated extends MarketChartEvent {
  final int index;

  const MarketChartUpdated(final Cryptocurrency cryptocurrency, this.index) : super(cryptocurrency);

  @override
  List<Object> get props => [cryptocurrency, index];
}
