import 'package:exchange/blocs/market_chart/market_chart_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/models/market_chart_data.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketChartBloc extends Bloc<MarketChartEvent, MarketChartState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;
  static const List<int> _days = [1, 7, 30, 90, 180, 360];

  MarketChartBloc(this._cryptocurrencyRepository)
      : super(const MarketChartState()) {
    on<MarketChartFetched>(_onMarketChartFetched);
    on<MarketChartUpdated>(_onMarketChartUpdated);
  }

  Future<void> _onMarketChartFetched(
      MarketChartFetched event, Emitter<MarketChartState> emit) async {
    emit(state.copyWith(marketChartStatus: MarketChartStatus.loading));

    try {
      final MarketChartData marketChart =
          await _cryptocurrencyRepository.fetchMarketChart(event.id);
      emit(state.copyWith(
          marketChartData: marketChart,
          marketChartStatus: MarketChartStatus.success));
    } on Exception {
      emit(state.copyWith(marketChartStatus: MarketChartStatus.failure));
    }
  }

  Future<void> _onMarketChartUpdated(
      MarketChartUpdated event, Emitter<MarketChartState> emit) async {
    emit(state.copyWith(marketChartStatus: MarketChartStatus.loading));

    try {
      final MarketChartData marketChart = await _cryptocurrencyRepository
          .fetchMarketChart(event.id, days: _days[event.index]);
      emit(state.copyWith(
          marketChartData: marketChart,
          marketChartStatus: MarketChartStatus.success));
    } on Exception {
      emit(state.copyWith(marketChartStatus: MarketChartStatus.failure));
    }
  }
}
