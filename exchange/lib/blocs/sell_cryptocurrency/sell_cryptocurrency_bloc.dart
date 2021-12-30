import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCryptocurrencyBloc
    extends Bloc<SellCryptocurrencyEvent, SellCryptocurrencyState> {
  SellCryptocurrencyBloc() : super(SellCryptocurrencyLoadInProgress()) {
    on<SellCryptocurrencyLoaded>(_onSellCryptocurrencyLoaded);
    on<SellCryptocurrencyAmountUpdated>(_onAmountSellCryptocurrencyUpdated);
    on<SellCryptocurrencyConfirmed>(_onConfirmedSellCryptocurrency);
  }

  void _onSellCryptocurrencyLoaded(
      SellCryptocurrencyLoaded event, Emitter<SellCryptocurrencyState> emit) {}

  void _onAmountSellCryptocurrencyUpdated(SellCryptocurrencyAmountUpdated event,
      Emitter<SellCryptocurrencyState> emit) {}

  void _onConfirmedSellCryptocurrency(SellCryptocurrencyConfirmed event,
      Emitter<SellCryptocurrencyState> emit) {}
}
