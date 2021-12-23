import 'package:exchange/blocs/market_chart/market_chart_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/models/market_chart_data.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketChartBloc extends Bloc<MarketChartEvent, MarketChartState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;
  final List<int> _days = const [1, 7, 30, 90, 180, 360];

  MarketChartBloc(this._cryptocurrencyRepository)
      : super(MarketChartLoadInProgress()) {
    on<MarketChartLoaded>(_onMarketChart);
    on<MarketChartUpdated>(_onMarketChart);
  }

  Future<void> _onMarketChart(
      MarketChartEvent event, Emitter<MarketChartState> emit) async {
    final MarketChartData marketChart;

    emit(MarketChartLoadInProgress());
    if (event is MarketChartLoaded) {
      try {
        marketChart = await _cryptocurrencyRepository
            .fetchMarketChart(event.cryptocurrency.id);
        emit(MarketChartLoadSuccess(event.cryptocurrency, marketChart));
      } on Exception {
        emit(MarketChartLoadFailure());
      }
    } else if (event is MarketChartUpdated) {
      try {
        marketChart = await _cryptocurrencyRepository.fetchMarketChart(
            event.cryptocurrency.id,
            days: _days[event.index]);
        emit(MarketChartLoadSuccess(event.cryptocurrency, marketChart));
      } on Exception {
        emit(MarketChartLoadFailure());
      }
    }
  }
}
