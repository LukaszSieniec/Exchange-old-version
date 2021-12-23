import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency_response.dart';

abstract class CryptocurrenciesState extends Equatable {
  const CryptocurrenciesState();

  @override
  List<Object> get props => [];
}

class CryptocurrenciesLoadInProgress extends CryptocurrenciesState {}

class CryptocurrenciesLoadSuccess extends CryptocurrenciesState {
  final List<CryptocurrencyResponse> cryptocurrencies;
  final List<CryptocurrencyResponse> trending;

  const CryptocurrenciesLoadSuccess(
      [this.cryptocurrencies = const [], this.trending = const []]);

  @override
  List<Object> get props => [cryptocurrencies, trending];
}

class CryptocurrenciesLoadFailure extends CryptocurrenciesState {}
