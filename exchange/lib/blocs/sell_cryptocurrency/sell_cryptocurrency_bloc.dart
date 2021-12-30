import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:exchange/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCryptocurrencyBloc
    extends Bloc<SellCryptocurrencyEvent, SellCryptocurrencyState> {
  final CryptocurrencyRepository cryptocurrencyRepository;
  final WalletBloc walletBloc;

  SellCryptocurrencyBloc(this.cryptocurrencyRepository, this.walletBloc)
      : super(SellCryptocurrencyLoadInProgress()) {
    on<SellCryptocurrencyLoaded>(_onSellCryptocurrencyLoaded);
    on<SellCryptocurrencyAmountUpdated>(_onSellCryptocurrencyAmountUpdated);
    on<SellCryptocurrencyConfirmed>(_onSellCryptocurrencyConfirmed);
  }

  void _onSellCryptocurrencyLoaded(SellCryptocurrencyLoaded event,
      Emitter<SellCryptocurrencyState> emit) async {
    final double price = await cryptocurrencyRepository.fetchPrice(event.id);

    final Cryptocurrency cryptocurrency =
        (walletBloc.state as WalletLoadSuccess)
            .cryptocurrencies
            .firstWhere((element) => element.id == event.id);

    emit(SellCryptocurrencyInitial(
        cryptocurrency, AccountBalance.readAccountBalance(), '0', 0, price));
  }

  void _onSellCryptocurrencyAmountUpdated(SellCryptocurrencyAmountUpdated event,
      Emitter<SellCryptocurrencyState> emit) {
    final SellCryptocurrencyInitial sellCryptocurrenciesInitial =
        (state as SellCryptocurrencyInitial);

    final String currentAmount = sellCryptocurrenciesInitial
        .amountCryptocurrency
        .appendNumber(event.amountCryptocurrency);

    final double price = sellCryptocurrenciesInitial.priceCryptocurrency;

    final Cryptocurrency cryptocurrency =
        sellCryptocurrenciesInitial.cryptocurrency;

    final double estimatedAmount =
        double.parse((double.parse(currentAmount) * price).toStringAsFixed(5));

    emit(SellCryptocurrencyInitial(
        cryptocurrency,
        AccountBalance.readAccountBalance(),
        currentAmount,
        estimatedAmount,
        price));
  }

  void _onSellCryptocurrencyConfirmed(SellCryptocurrencyConfirmed event,
      Emitter<SellCryptocurrencyState> emit) {}
}
