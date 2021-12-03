import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/services/cryptocurrency_service.dart';

class CryptocurrencyRepository {
  final CryptocurrencyService _cryptocurrencyService;

  CryptocurrencyRepository(this._cryptocurrencyService);

  Future<List<Cryptocurrency>> fetchCryptocurrencies() async {
    final List<Cryptocurrency> cryptocurrencies =
        await _cryptocurrencyService.fetchCryptocurrencies();
    return cryptocurrencies;
  }
}
