import 'dart:convert';

import 'package:exchange/models/cryptocurrency.dart';
import 'package:http/http.dart' as http;

class CryptocurrencyService {
  final String _baseUrl = 'https://api.coingecko.com/api/v3/';
  final http.Client _httpClient = http.Client();

  /// Example endpoint: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&sparkline=false
  Future<List<Cryptocurrency>> fetchCryptocurrencies() async {
    final String requestUrl = _baseUrl;

    final response = await _httpClient.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.body);
      return json.map((element) => Cryptocurrency.fromJson(element)).toList();
    } else {
      throw Exception('Error!');
    }
  }

  /// Example endpoint: https://api.coingecko.com/api/v3/coins/bitcoin
  Future<Cryptocurrency> fetchCryptocurrency(String id) async {
    final String requestUrl = '$_baseUrl/coins/$id';

    final response = await _httpClient.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      return Cryptocurrency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error!');
    }
  }
}
