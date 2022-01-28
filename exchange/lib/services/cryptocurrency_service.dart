import 'package:dio/dio.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/market_chart_data.dart';
import 'package:exchange/models/popular_cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class CryptocurrencyService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.coingecko.com/api/v3/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  Future<List<CryptocurrencyResponse>> fetchCryptocurrencies() async {
    final response = await _dio.get('coins/markets', queryParameters: {
      'vs_currency': 'usd',
      'order': 'market_cap_desc',
      'per_page': 10,
      'sparkline': true
    });

    if (response.statusCode == 200) {
      debugPrint('Success!');
      final Iterable json = response.data;
      return json
          .map((element) => CryptocurrencyResponse.fromJson(element))
          .toList();
    } else {
      throw Exception('Error!');
    }
  }

  Future<List<CryptocurrencyResponse>> fetchCryptocurrenciesByIds(
      List<String> ids) async {
    final response = await _dio.get('coins/markets', queryParameters: {
      'vs_currency': 'usd',
      'ids': '$ids',
      'order': 'market_cap_desc',
      'sparkline': true
    });

    if (response.statusCode == 200) {
      final Iterable json = response.data;
      return json
          .map((element) => CryptocurrencyResponse.fromJson(element))
          .toList();
    } else {
      throw Exception('Error!');
    }
  }

  Future<List<PopularCryptocurrency>> fetchTrending() async {
    final response = await _dio.get('search/trending');

    if (response.statusCode == 200) {
      final Iterable json = response.data['coins'];
      return json
          .map((element) => PopularCryptocurrency.fromJson(element))
          .toList();
    } else {
      throw Exception('Error!');
    }
  }

  Future<CryptocurrencyResponse> fetchCryptocurrency(final String id) async {
    final response = await _dio.get('coins/$id');

    if (response.statusCode == 200) {
      return CryptocurrencyResponse.fromJson(response.data);
    } else {
      throw Exception('Error!');
    }
  }

  Future<MarketChartData> fetchMarketChart(
      final String id, final int days) async {
    final response = await _dio.get('coins/$id/market_chart',
        queryParameters: {'vs_currency': 'usd', 'days': days});

    if (response.statusCode == 200) {
      return MarketChartData.fromJson(response.data);
    } else {
      throw Exception('Error!');
    }
  }

  Future<dynamic> fetchPrice(final String id) async {
    final response = await _dio.get('simple/price',
        queryParameters: {'vs_currencies': 'usd', 'ids': id});

    if (response.statusCode == 200) {
      final Map<String, dynamic> price = response.data[id];
      return price['usd'];
    } else {
      throw Exception('Error!');
    }
  }
}
