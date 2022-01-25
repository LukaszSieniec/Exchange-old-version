import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

enum CryptocurrenciesStatus { initial, loading, success, failure }

class CryptocurrenciesState extends Equatable {
  final List<CryptocurrencyResponse> cryptocurrencies;
  final List<CryptocurrencyResponse> trending;

  final CryptocurrenciesStatus cryptocurrenciesStatus;

  const CryptocurrenciesState(
      {this.cryptocurrencies = const [],
      this.trending = const [],
      this.cryptocurrenciesStatus = CryptocurrenciesStatus.initial});

  CryptocurrenciesState copyWith(
      {List<CryptocurrencyResponse>? cryptocurrencies,
      List<CryptocurrencyResponse>? trending,
      CryptocurrenciesStatus? cryptocurrenciesStatus}) {
    return CryptocurrenciesState(
        cryptocurrencies: cryptocurrencies ?? this.cryptocurrencies,
        trending: trending ?? this.trending,
        cryptocurrenciesStatus:
            cryptocurrenciesStatus ?? this.cryptocurrenciesStatus);
  }

  @override
  List<Object> get props =>
      [cryptocurrencies, trending, cryptocurrenciesStatus];
}
