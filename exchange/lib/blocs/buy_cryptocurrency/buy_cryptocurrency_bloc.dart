import 'package:flutter_bloc/flutter_bloc.dart';

import 'buy_cryptocurrency_event.dart';
import 'buy_cryptocurrency_state.dart';

class BuyCryptocurrenciesBloc
    extends Bloc<BuyCryptocurrenciesEvent, BuyCryptocurrenciesState> {
  BuyCryptocurrenciesBloc()
      : super(const BuyCryptocurrenciesInitial('0', '0.0')) {
    on<AmountCryptocurrencyUpdated>(_onAmountCryptocurrencyUpdated);
  }

  void _onAmountCryptocurrencyUpdated(AmountCryptocurrencyUpdated event,
      Emitter<BuyCryptocurrenciesState> emit) async {
    emit(BuyCryptocurrenciesInitial('0', state.amount + event.number));
  }
}
