import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCryptocurrencyBloc
    extends Bloc<SellCryptocurrencyEvent, SellCryptocurrencyState> {
  final WalletBloc walletBloc;

  SellCryptocurrencyBloc(this.walletBloc)
      : super(SellCryptocurrencyLoadInProgress()) {
    on<SellCryptocurrencyLoaded>(_onSellCryptocurrencyLoaded);
    on<SellCryptocurrencyAmountUpdated>(_onSellCryptocurrencyAmountUpdated);
    on<SellCryptocurrencyConfirmed>(_onSellCryptocurrencyConfirmed);
  }

  void _onSellCryptocurrencyLoaded(
      SellCryptocurrencyLoaded event, Emitter<SellCryptocurrencyState> emit) {
    final Cryptocurrency cryptocurrency =
        (walletBloc.state as WalletLoadSuccess)
            .cryptocurrencies
            .firstWhere((element) => element.id == event.id);

    emit(SellCryptocurrencyInitial(
        cryptocurrency, AccountBalance.readAccountBalance(), '0', 0));
  }

  void _onSellCryptocurrencyAmountUpdated(SellCryptocurrencyAmountUpdated event,
      Emitter<SellCryptocurrencyState> emit) {
    final String currentAmount = (state as SellCryptocurrencyInitial)
        .amountCryptocurrency
        .appendNumber(event.amountCryptocurrency);

    final Cryptocurrency cryptocurrency =
        (state as SellCryptocurrencyInitial).cryptocurrency;

    emit(SellCryptocurrencyInitial(
        cryptocurrency, AccountBalance.readAccountBalance(), currentAmount, 0));
  }

  void _onSellCryptocurrencyConfirmed(SellCryptocurrencyConfirmed event,
      Emitter<SellCryptocurrencyState> emit) {}
}
