import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_event.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/models/popular_cryptocurrency.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptocurrenciesBloc
    extends Bloc<CryptocurrenciesEvent, CryptocurrenciesState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;

  CryptocurrenciesBloc(this._cryptocurrencyRepository)
      : super(const CryptocurrenciesState()) {
    on<CryptocurrenciesFetched>(_onCryptocurrenciesFetched);
  }

  Future<void> _onCryptocurrenciesFetched(CryptocurrenciesFetched event,
      Emitter<CryptocurrenciesState> emit) async {
    emit(
        state.copyWith(cryptocurrenciesStatus: CryptocurrenciesStatus.loading));
    try {
      final List<List<CryptocurrencyResponse>> cryptocurrencies =
          await _fetchCryptocurrencies();

      emit(state.copyWith(
          cryptocurrencies: cryptocurrencies[0],
          trending: cryptocurrencies[1],
          cryptocurrenciesStatus: CryptocurrenciesStatus.success));
    } on Exception {
      emit(state.copyWith(
          cryptocurrenciesStatus: CryptocurrenciesStatus.failure));
    }

    await emit.forEach<List<List<CryptocurrencyResponse>>>(
        Stream.periodic(const Duration(seconds: 60))
            .asyncMap((_) => _fetchCryptocurrencies()),
        onData: (data) => state.copyWith(
            cryptocurrencies: data[0],
            trending: data[1],
            cryptocurrenciesStatus: CryptocurrenciesStatus.success),
        onError: (_, __) => state.copyWith(
            cryptocurrenciesStatus: CryptocurrenciesStatus.failure));
  }

  Future<List<List<CryptocurrencyResponse>>> _fetchCryptocurrencies() async {
    final List<PopularCryptocurrency> trendingBasicInformations =
        await _cryptocurrencyRepository.fetchTrending();

    final List<String> ids = <String>[];

    for (final singleBasicInformation in trendingBasicInformations) {
      ids.add(singleBasicInformation.id);
    }

    final List<List<CryptocurrencyResponse>> cryptocurrencies =
        await Future.wait([
      _cryptocurrencyRepository.fetchCryptocurrencies(),
      _cryptocurrencyRepository.fetchCryptocurrenciesByIds(ids)
    ]);

    return cryptocurrencies;
  }
}
