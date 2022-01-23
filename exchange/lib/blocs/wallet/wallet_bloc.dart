import 'dart:async';

import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_state.dart';
import 'package:exchange/blocs/wallet/wallet_event.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final CryptocurrencyRepository cryptocurrencyRepository;
  final BuyCryptocurrencyBloc buyCryptocurrencyBloc;

  late final StreamSubscription buyCryptocurrencySubscription;

  WalletBloc(this.cryptocurrencyRepository, this.buyCryptocurrencyBloc)
      : super(WalletLoadInProgress()) {
    on<WalletLoaded>(_onWalletLoaded);
    on<WalletUpdated>(_onWalletUpdated);

    void onWalletChanged(state) {
      if (state is BuyCryptocurrencySuccess) {
        add(WalletUpdated(state.cryptocurrency));
      }
    }

    onWalletChanged(buyCryptocurrencyBloc.state);
    buyCryptocurrencySubscription =
        buyCryptocurrencyBloc.stream.listen(onWalletChanged);
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

  Future<void> _onWalletUpdated(
      WalletUpdated event, Emitter<WalletState> emit) async {
    final List<Cryptocurrency> cryptocurrencies = (state as WalletLoadSuccess)
        .cryptocurrencies
        .map((cryptocurrency) => cryptocurrency.id == event.cryptocurrency.id
            ? cryptocurrency.copyWith(
                amount: cryptocurrency.amount + event.cryptocurrency.amount)
            : cryptocurrency)
        .toList();

    final bool isExist = (state as WalletLoadSuccess)
        .cryptocurrencies
        .any((element) => element.id == event.cryptocurrency.id);

    if (!isExist) cryptocurrencies.add(event.cryptocurrency);

    emit(WalletLoadSuccess(
        AccountBalance.readAccountBalance(), cryptocurrencies));
  }

  @override
  Future<void> close() {
    buyCryptocurrencySubscription.cancel();
    return super.close();
  }
}
