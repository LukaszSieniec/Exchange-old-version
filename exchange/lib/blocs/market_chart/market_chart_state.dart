import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/market_chart_data.dart';

abstract class MarketChartState extends Equatable {
  const MarketChartState();

  @override
  List<Object> get props => [];
}

class MarketChartLoadInProgress extends MarketChartState {}

class MarketChartLoadSuccess extends MarketChartState {
  final CryptocurrencyResponse cryptocurrency;
  final MarketChartData marketChartData;

  const MarketChartLoadSuccess(this.cryptocurrency, this.marketChartData);

  @override
  List<Object> get props => [marketChartData];
}

class MarketChartLoadFailure extends MarketChartState {}
