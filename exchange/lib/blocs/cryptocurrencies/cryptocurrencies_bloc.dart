import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_event.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/popular_cryptocurrency.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptocurrenciesBloc
    extends Bloc<CryptocurrenciesEvent, CryptocurrenciesState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;

  CryptocurrenciesBloc(this._cryptocurrencyRepository)
      : super(CryptocurrenciesStateLoadInProgress()) {
    on<CryptocurrenciesLoaded>(_onCryptocurrenciesLoaded);
  }

  void _onCryptocurrenciesLoaded(
      CryptocurrenciesLoaded event, Emitter<CryptocurrenciesState> emit) async {
    try {
      final List<PopularCryptocurrency> trendingBasicInformations =
          await _cryptocurrencyRepository.fetchTrending();

      final List<String> ids = <String>[];

      for (final singleBasicInformation in trendingBasicInformations) {
        ids.add(singleBasicInformation.id);
      }

      final List<List<Cryptocurrency>> cryptocurrencies = await Future.wait([
        _cryptocurrencyRepository.fetchCryptocurrencies(),
        _cryptocurrencyRepository.fetchCryptocurrenciesByIds(ids)
      ]);

      emit(CryptocurrenciesLoadSuccess(
          cryptocurrencies[0], cryptocurrencies[1]));
    } on Exception {
      emit(CryptocurrenciesLoadFailure());
    }
  }
}
