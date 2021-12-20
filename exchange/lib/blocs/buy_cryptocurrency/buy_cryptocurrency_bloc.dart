import 'package:exchange/database/account_balance.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buy_cryptocurrency_event.dart';
import 'buy_cryptocurrency_state.dart';

class BuyCryptocurrenciesBloc
    extends Bloc<BuyCryptocurrenciesEvent, BuyCryptocurrenciesState> {
  BuyCryptocurrenciesBloc()
      : super(BuyCryptocurrenciesInitial(
            AccountBalance.readAccountBalance(), '0', 0)) {
    on<AmountCryptocurrencyUpdated>(_onAmountCryptocurrencyUpdated);
    on<ConfirmedBuyCryptocurrency>(_onConfirmedCryptocurrency);
  }

  void _onAmountCryptocurrencyUpdated(AmountCryptocurrencyUpdated event,
      Emitter<BuyCryptocurrenciesState> emit) async {
    final currentNumber =
        (state as BuyCryptocurrenciesInitial).amount.appendNumber(event.number);

    emit(BuyCryptocurrenciesInitial(
        AccountBalance.readAccountBalance(), currentNumber, 0));
  }

  void _onConfirmedCryptocurrency(ConfirmedBuyCryptocurrency event,
      Emitter<BuyCryptocurrenciesState> emit) async {}
}
