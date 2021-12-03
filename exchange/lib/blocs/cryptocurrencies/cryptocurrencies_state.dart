import 'package:equatable/equatable.dart';
import 'package:exchange/models/cryptocurrency.dart';

abstract class CryptocurrenciesState extends Equatable {
  const CryptocurrenciesState();

  @override
  List<Object> get props => [];
}

class CryptocurrenciesStateLoadInProgress extends CryptocurrenciesState {}

class CryptocurrenciesLoadSuccess extends CryptocurrenciesState {
  final List<Cryptocurrency> cryptocurrencies;

  const CryptocurrenciesLoadSuccess([this.cryptocurrencies = const []]);

  @override
  List<Object> get props => [cryptocurrencies];
}

class CryptocurrenciesLoadFailure extends CryptocurrenciesState {}
