import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_event.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptocurrenciesBloc
    extends Bloc<CryptocurrenciesEvent, CryptocurrenciesState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;

  CryptocurrenciesBloc(this._cryptocurrencyRepository)
      : super(CryptocurrenciesStateLoadInProgress()) {
    on<CryptocurrenciesLoaded>(_onCryptocurrenciesRequested);
  }

  void _onCryptocurrenciesRequested(
      CryptocurrenciesLoaded event, Emitter<CryptocurrenciesState> emit) async {
    try {
      final List<Cryptocurrency> cryptocurrencies =
          await _cryptocurrencyRepository.fetchCryptocurrencies();
      emit(CryptocurrenciesLoadSuccess(cryptocurrencies));
    } on Exception {
      emit(CryptocurrenciesLoadFailure());
    }
  }
}
