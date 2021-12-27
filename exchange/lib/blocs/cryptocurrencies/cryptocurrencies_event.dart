import 'package:equatable/equatable.dart';

abstract class CryptocurrenciesEvent extends Equatable {
  const CryptocurrenciesEvent();

  @override
  List<Object> get props => [];
}

class CryptocurrenciesFetched extends CryptocurrenciesEvent {}
