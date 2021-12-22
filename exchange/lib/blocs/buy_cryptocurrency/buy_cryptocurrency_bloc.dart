import 'package:exchange/blocs/market_chart/market_chart_bloc.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buy_cryptocurrency_event.dart';
import 'buy_cryptocurrency_state.dart';

class BuyCryptocurrenciesBloc
    extends Bloc<BuyCryptocurrenciesEvent, BuyCryptocurrenciesState> {
  final MarketChartBloc marketChartBloc;

  BuyCryptocurrenciesBloc(this.marketChartBloc)
      : super(BuyCryptocurrenciesInitial(
            AccountBalance.readAccountBalance(), '0', 0)) {
    on<AmountCryptocurrencyUpdated>(_onAmountCryptocurrencyUpdated);
    on<ConfirmedBuyCryptocurrency>(_onConfirmedCryptocurrency);
  }

  void _onAmountCryptocurrencyUpdated(AmountCryptocurrencyUpdated event,
      Emitter<BuyCryptocurrenciesState> emit) async {
    final String currentNumber =
        (state as BuyCryptocurrenciesInitial).amount.appendNumber(event.number);

    final double estimatedQuantity = double.parse((double.parse(currentNumber) /
            (marketChartBloc.state as MarketChartLoadSuccess)
                .cryptocurrency
                .currentPrice)
        .toStringAsFixed(5));

    emit(BuyCryptocurrenciesInitial(
        AccountBalance.readAccountBalance(), currentNumber, estimatedQuantity));
  }

  void _onConfirmedCryptocurrency(ConfirmedBuyCryptocurrency event,
      Emitter<BuyCryptocurrenciesState> emit) async {}
}
