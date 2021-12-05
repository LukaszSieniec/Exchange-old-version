import 'package:equatable/equatable.dart';
import 'package:exchange/models/market_chart_data.dart';

abstract class MarketChartState extends Equatable {
  const MarketChartState();

  @override
  List<Object> get props => [];
}

class MarketChartStateLoadInProgress extends MarketChartState {}

class MarketChartLoadSuccess extends MarketChartState {
  final MarketChartData marketChartData;

  const MarketChartLoadSuccess(this.marketChartData);

  @override
  List<Object> get props => [marketChartData];
}

class MarketChartLoadFailure extends MarketChartState {}
