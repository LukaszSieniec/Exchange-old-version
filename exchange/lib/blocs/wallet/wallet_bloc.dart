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
  final CryptocurrencyRepository _cryptocurrencyRepository;

  final BuyCryptocurrencyBloc _buyCryptocurrencyBloc;
  final SellCryptocurrencyBloc _sellCryptocurrencyBloc;

  late final StreamSubscription _buyCryptocurrencySubscription;
  late final StreamSubscription _sellCryptocurrencySubscription;

  WalletBloc(this._cryptocurrencyRepository, this._buyCryptocurrencyBloc,
      this._sellCryptocurrencyBloc)
      : super(const WalletState()) {
    on<WalletLoaded>(_onWalletLoaded);
    on<WalletUpdatedPurchase>(_onWalletUpdatedPurchase);
    on<WalletUpdatedSale>(_onWalletUpdatedSale);

    void onWalletStateChangedByPurchase(BuyCryptocurrencyState state) {
      if (state.buyCryptocurrencyStatus == BuyCryptocurrencyStatus.success) {
        add(WalletUpdatedPurchase(state.cryptocurrency!));
      }
    }

    void onWalletStateChangedBySale(SellCryptocurrencyState state) {
      if (state.sellCryptocurrencyStatus == SellCryptocurrencyStatus.success) {
        add(WalletUpdatedSale(state.cryptocurrency!));
      }
    }

    _buyCryptocurrencySubscription =
        _buyCryptocurrencyBloc.stream.listen(onWalletStateChangedByPurchase);
    _sellCryptocurrencySubscription =
        _sellCryptocurrencyBloc.stream.listen(onWalletStateChangedBySale);
  }

  Future<void> _onWalletLoaded(
      WalletLoaded event, Emitter<WalletState> emit) async {
    emit(state.copyWith(walletStatus: WalletStatus.loading));
    try {
      final List<Cryptocurrency> cryptocurrencies =
          await _cryptocurrencyRepository.readAllCryptocurrencies();
      final double accountBalance = AccountBalance.readAccountBalance();

      emit(state.copyWith(
          cryptocurrencies: cryptocurrencies,
          accountBalance: accountBalance,
          walletStatus: WalletStatus.success));
    } on Exception {
      emit(state.copyWith(walletStatus: WalletStatus.failure));
    }
  }

  Future<void> _onWalletUpdatedPurchase(
      WalletUpdatedPurchase event, Emitter<WalletState> emit) async {
    final List<Cryptocurrency> cryptocurrencies = state.cryptocurrencies
        .map((cryptocurrency) => cryptocurrency.id == event.cryptocurrency.id
            ? cryptocurrency.copyWith(
                amount: (cryptocurrency.amount + event.cryptocurrency.amount))
            : cryptocurrency)
        .toList();

    final bool isExist = state.cryptocurrencies
        .any((element) => element.id == event.cryptocurrency.id);

    if (!isExist) cryptocurrencies.add(event.cryptocurrency);

    emit(state.copyWith(
        cryptocurrencies: cryptocurrencies,
        accountBalance: AccountBalance.readAccountBalance()));
    _createOrUpdateCryptocurrency(event.cryptocurrency);
  }

  Future<void> _onWalletUpdatedSale(
      WalletUpdatedSale event, Emitter<WalletState> emit) async {
    final List<Cryptocurrency> cryptocurrencies = state.cryptocurrencies
        .map((cryptocurrency) => cryptocurrency.id == event.cryptocurrency.id
            ? event.cryptocurrency
            : cryptocurrency)
        .toList();

    emit(state.copyWith(
        cryptocurrencies: cryptocurrencies,
        accountBalance: AccountBalance.readAccountBalance()));
    _updateCryptocurrency(event.cryptocurrency);
  }

  Future<void> _createOrUpdateCryptocurrency(Cryptocurrency cryptocurrency) =>
      _cryptocurrencyRepository.createOrUpdateCryptocurrency(cryptocurrency);

  Future<void> _updateCryptocurrency(Cryptocurrency cryptocurrency) =>
      _cryptocurrencyRepository.updateCryptocurrency(cryptocurrency);

  @override
  Future<void> close() {
    _buyCryptocurrencySubscription.cancel();
    _sellCryptocurrencySubscription.cancel();
    return super.close();
  }
}
