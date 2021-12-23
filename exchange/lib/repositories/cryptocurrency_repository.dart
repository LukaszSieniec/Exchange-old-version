import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/market_chart_data.dart';
import 'package:exchange/models/popular_cryptocurrency.dart';
import 'package:exchange/services/cryptocurrency_service.dart';

class CryptocurrencyRepository {
  final CryptocurrencyService _cryptocurrencyService;

  CryptocurrencyRepository(this._cryptocurrencyService);

  Future<List<CryptocurrencyResponse>> fetchCryptocurrencies() async {
    final List<CryptocurrencyResponse> cryptocurrencies =
        await _cryptocurrencyService.fetchCryptocurrencies();
    return cryptocurrencies;
  }

  Future<List<CryptocurrencyResponse>> fetchCryptocurrenciesByIds(
      List<String> ids) async {
    final List<CryptocurrencyResponse> cryptocurrencies =
        await _cryptocurrencyService.fetchCryptocurrenciesByIds(ids);
    return cryptocurrencies;
  }

  Future<List<PopularCryptocurrency>> fetchTrending() async {
    final List<PopularCryptocurrency> cryptocurrencies =
        await _cryptocurrencyService.fetchTrending();
    return cryptocurrencies;
  }

  Future<CryptocurrencyResponse> fetchCryptocurrency(String id) async {
    final CryptocurrencyResponse cryptocurrency =
        await _cryptocurrencyService.fetchCryptocurrency(id);
    return cryptocurrency;
  }

  Future<MarketChartData> fetchMarketChart(String id, {int days = 1}) async {
    final MarketChartData marketChartData =
        await _cryptocurrencyService.fetchMarketChart(id, days);
    return marketChartData;
  }
}
