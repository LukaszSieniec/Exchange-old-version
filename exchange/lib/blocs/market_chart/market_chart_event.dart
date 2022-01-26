import 'package:equatable/equatable.dart';

abstract class MarketChartEvent extends Equatable {
  final String id;

  const MarketChartEvent(this.id);
}

class MarketChartFetched extends MarketChartEvent {
  const MarketChartFetched(String id) : super(id);

  @override
  List<Object> get props => [id];
}

class MarketChartUpdated extends MarketChartEvent {
  final int index;

  const MarketChartUpdated(String id, this.index) : super(id);

  @override
  List<Object> get props => [id, index];
}
