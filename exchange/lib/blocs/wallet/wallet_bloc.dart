import 'dart:async';

import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_state.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/blocs/wallet/wallet_event.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final CryptocurrencyRepository cryptocurrencyRepository;
  final BuyCryptocurrencyBloc buyCryptocurrencyBloc;
  final SellCryptocurrencyBloc sellCryptocurrencyBloc;

  late final StreamSubscription buyCryptocurrencySubscription;
  late final StreamSubscription sellCryptocurrencySubscription;

  WalletBloc(this.cryptocurrencyRepository, this.buyCryptocurrencyBloc,
      this.sellCryptocurrencyBloc)
      : super(WalletLoadInProgress()) {
    on<WalletLoaded>(_onWalletLoaded);
    on<WalletUpdatedPurchase>(_onWalletUpdatedPurchase);
    on<WalletUpdatedSale>(_onWalletUpdatedSale);

    void onWalletStateChanged(state) {
      if (state is BuyCryptocurrencySuccess) {
        add(WalletUpdatedPurchase(state.cryptocurrency));
      } else if (state is SellCryptocurrencySuccess) {
        add(WalletUpdatedSale(state.cryptocurrency));
      }
    }

    buyCryptocurrencySubscription =
        buyCryptocurrencyBloc.stream.listen(onWalletStateChanged);
    sellCryptocurrencySubscription =
        sellCryptocurrencyBloc.stream.listen(onWalletStateChanged);
  }

  Future<void> _onWalletLoaded(
      WalletLoaded event, Emitter<WalletState> emit) async {
    try {
      final List<Cryptocurrency> cryptocurrencies =
          await cryptocurrencyRepository.readAllCryptocurrencies();
      final double accountBalance = AccountBalance.readAccountBalance();

      emit(WalletLoadSuccess(accountBalance, cryptocurrencies));
    } on Exception {
      emit(WalletLoadFailure());
    }
  }

  Future<void> _onWalletUpdatedPurchase(
      WalletUpdatedPurchase event, Emitter<WalletState> emit) async {
    final List<Cryptocurrency> cryptocurrencies = (state as WalletLoadSuccess)
        .cryptocurrencies
        .map((cryptocurrency) => cryptocurrency.id == event.cryptocurrency.id
            ? cryptocurrency.copyWith(
                amount: (cryptocurrency.amount + event.cryptocurrency.amount))
            : cryptocurrency)
        .toList();

    final bool isExist = (state as WalletLoadSuccess)
        .cryptocurrencies
        .any((element) => element.id == event.cryptocurrency.id);

    if (!isExist) cryptocurrencies.add(event.cryptocurrency);

    emit(WalletLoadSuccess(
        AccountBalance.readAccountBalance(), cryptocurrencies));
  }

  Future<void> _onWalletUpdatedSale(
      WalletUpdatedSale event, Emitter<WalletState> emit) async {
    final List<Cryptocurrency> cryptocurrencies = (state as WalletLoadSuccess)
        .cryptocurrencies
        .map((cryptocurrency) => cryptocurrency.id == event.cryptocurrency.id
            ? event.cryptocurrency
            : cryptocurrency)
        .toList();

    emit(WalletLoadSuccess(
        AccountBalance.readAccountBalance(), cryptocurrencies));
  }

  @override
  Future<void> close() {
    buyCryptocurrencySubscription.cancel();
    sellCryptocurrencySubscription.cancel();
    return super.close();
  }
}
