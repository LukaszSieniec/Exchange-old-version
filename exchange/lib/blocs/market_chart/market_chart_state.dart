import 'package:equatable/equatable.dart';
import 'package:exchange/models/market_chart_data.dart';

enum MarketChartStatus { initial, loading, success, failure }

class MarketChartState extends Equatable {
  final MarketChartData? marketChartData;

  final MarketChartStatus marketChartStatus;

  const MarketChartState(
      {this.marketChartData,
      this.marketChartStatus = MarketChartStatus.initial});

  MarketChartState copyWith(
      {MarketChartData? marketChartData,
      MarketChartStatus? marketChartStatus}) {
    return MarketChartState(
        marketChartData: marketChartData ?? this.marketChartData,
        marketChartStatus: marketChartStatus ?? this.marketChartStatus);
  }

  @override
  List<Object?> get props => [marketChartData, marketChartStatus];
}
