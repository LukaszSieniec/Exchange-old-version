import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exchange/models/cryptocurrency.dart';

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
      'sparkline': false
    });

    if (response.statusCode == 200) {
      final Iterable json = response.data;
      return json.map((element) => Cryptocurrency.fromJson(element)).toList();
    } else {
      throw Exception('Error!');
    }
  }

  /// Example endpoint: https://api.coingecko.com/api/v3/coins/bitcoin
  Future<Cryptocurrency> fetchCryptocurrency(String id) async {
    final response = await _dio.get('coins/$id');

    if (response.statusCode == 200) {
      return Cryptocurrency.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Error!');
    }
  }
}
