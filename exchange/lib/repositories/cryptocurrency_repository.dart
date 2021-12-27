import 'package:exchange/database/cryptocurrency_database.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/market_chart_data.dart';
import 'package:exchange/models/popular_cryptocurrency.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/services/cryptocurrency_service.dart';

class CryptocurrencyRepository {
  final CryptocurrencyService _cryptocurrencyService;
  final CryptocurrencyDatabase _cryptocurrencyDatabase;

  CryptocurrencyRepository(
      this._cryptocurrencyService, this._cryptocurrencyDatabase);

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

  Future<void> createOrUpdateCryptocurrency(
      Cryptocurrency cryptocurrency) async {
    final bool isExist =
        await _cryptocurrencyDatabase.isExistCryptocurrency(cryptocurrency);

    if (isExist) {
      final Cryptocurrency existingCryptocurrency =
          await _cryptocurrencyDatabase.readCryptocurrency(cryptocurrency.id);

      final double amount =
          cryptocurrency.amount + existingCryptocurrency.amount;

      _cryptocurrencyDatabase.updateCryptocurrency(
          existingCryptocurrency.copyWith(amount: amount));
    } else {
      _cryptocurrencyDatabase.createCryptocurrency(cryptocurrency);
    }
  }

  Future<void> createCryptocurrency(Cryptocurrency cryptocurrency) async =>
      _cryptocurrencyDatabase.createCryptocurrency(cryptocurrency);

  Future<Cryptocurrency> readCryptocurrency(String id) async {
    final Cryptocurrency cryptocurrency =
        await _cryptocurrencyDatabase.readCryptocurrency(id);
    return cryptocurrency;
  }

  Future<void> updateCryptocurrency(Cryptocurrency cryptocurrency) async =>
      _cryptocurrencyDatabase.updateCryptocurrency(cryptocurrency);

  Future<void> deleteCryptocurrency(String id) async =>
      _cryptocurrencyDatabase.deleteCryptocurrency(id);

  Future<List<Cryptocurrency>> readAllCryptocurrencies() async {
    final List<Cryptocurrency> cryptocurrencies =
        await _cryptocurrencyDatabase.readAllCryptocurrencies();
    return cryptocurrencies;
  }

  Future<void> createTransaction(Transaction transaction) async =>
      _cryptocurrencyDatabase.createTransaction(transaction);

  Future<Transaction> readTransaction(int id) async {
    final Transaction transaction =
        await _cryptocurrencyDatabase.readTransaction(id);
    return transaction;
  }

  Future<void> updateTransaction(Transaction transaction) async =>
      _cryptocurrencyDatabase.updateTransaction(transaction);

  Future<void> deleteTransaction(String id) async =>
      _cryptocurrencyDatabase.deleteTransaction(id);

  Future<List<Transaction>> readAllTransactions() async {
    final List<Transaction> transactions =
        await _cryptocurrencyDatabase.readAllTransactions();
    return transactions;
  }
}
