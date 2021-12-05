import 'package:exchange/blocs/market_chart/market_chart_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/models/market_chart_data.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketChartBloc extends Bloc<MarketChartEvent, MarketChartState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;
  final List<int> _days = [1, 7, 30, 90, 180, 360];

  MarketChartBloc(this._cryptocurrencyRepository)
      : super(MarketChartStateLoadInProgress()) {
    on<MarketChartLoaded>(_onMarketChart);
    on<MarketChartUpdated>(_onMarketChart);
  }

  void _onMarketChart(
      MarketChartEvent event, Emitter<MarketChartState> emit) async {
    emit(MarketChartStateLoadInProgress());
    if (event is MarketChartLoaded) {
      try {
        final MarketChartData marketChart =
            await _cryptocurrencyRepository.fetchMarketChart(event.id);

        emit(MarketChartLoadSuccess(marketChart));
      } on Exception {
        emit(MarketChartLoadFailure());
      }
    } else if (event is MarketChartUpdated) {
      try {
        final MarketChartData marketChart = await _cryptocurrencyRepository
            .fetchMarketChart(event.id, days: _days[event.index]);
        emit(MarketChartLoadSuccess(marketChart));
      } on Exception {
        emit(MarketChartLoadFailure());
      }
    }
  }
}
