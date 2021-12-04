import 'package:dio/dio.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/popular_cryptocurrency.dart';

class CryptocurrencyService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.coingecko.com/api/v3/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  Future<List<Cryptocurrency>> fetchCryptocurrencies() async {
    final response = await _dio.get('coins/markets', queryParameters: {
      'vs_currency': 'usd',
      'order': 'market_cap_desc',
      'per_page': 10,
      'sparkline': true
    });

    if (response.statusCode == 200) {
      final Iterable json = response.data;
      return json.map((element) => Cryptocurrency.fromJson(element)).toList();
    } else {
      throw Exception('Error!');
    }
  }

  Future<List<Cryptocurrency>> fetchCryptocurrenciesByIds(
      List<String> ids) async {
    final response = await _dio.get('coins/markets', queryParameters: {
      'vs_currency': 'usd',
      'ids': '$ids',
      'order': 'market_cap_desc',
      'sparkline': true
    });

    if (response.statusCode == 200) {
      final Iterable json = response.data;
      return json.map((element) => Cryptocurrency.fromJson(element)).toList();
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

  Future<Cryptocurrency> fetchCryptocurrency(String id) async {
    final response = await _dio.get('coins/$id');

    if (response.statusCode == 200) {
      return Cryptocurrency.fromJson(response.data);
    } else {
      throw Exception('Error!');
    }
  }
}
