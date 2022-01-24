import 'dart:async';

import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_state.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/blocs/transactions/transactions_event.dart';
import 'package:exchange/blocs/transactions/transactions_state.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final CryptocurrencyRepository cryptocurrencyRepository;

  final BuyCryptocurrencyBloc buyCryptocurrencyBloc;
  final SellCryptocurrencyBloc sellCryptocurrencyBloc;

  late final StreamSubscription buyCryptocurrencySubscription;
  late final StreamSubscription sellCryptocurrencySubscription;

  TransactionsBloc(this.cryptocurrencyRepository, this.buyCryptocurrencyBloc,
      this.sellCryptocurrencyBloc)
      : super(TransactionsLoadInProgress()) {
    on<TransactionsLoaded>(_onTransactionsLoaded);
    on<TransactionsUpdated>(_onTransactionsUpdated);

    void onTransactionsStateChanged(state) {
      if (state is BuyCryptocurrencySuccess) {
        add(TransactionsUpdated(state.transaction));
      } else if (state is SellCryptocurrencySuccess) {
        add(TransactionsUpdated(state.transaction));
      }
    }

    buyCryptocurrencySubscription =
        buyCryptocurrencyBloc.stream.listen(onTransactionsStateChanged);
    sellCryptocurrencySubscription =
        sellCryptocurrencyBloc.stream.listen(onTransactionsStateChanged);
  }

  Future<void> _onTransactionsLoaded(
      TransactionsLoaded event, Emitter<TransactionsState> emit) async {
    try {
      final List<Transaction> transactions =
          await cryptocurrencyRepository.readAllTransactions();
      emit(TransactionsLoadSuccess(transactions));
    } on Exception {
      emit(TransactionsLoadFailure());
    }
  }

  Future<void> _onTransactionsUpdated(
      TransactionsUpdated event, Emitter<TransactionsState> emit) async {
    final List<Transaction> transactions =
        (state as TransactionsLoadSuccess).transactions..add(event.transaction);

    emit(TransactionsLoadSuccess(transactions));
  }

  @override
  Future<void> close() {
    buyCryptocurrencySubscription.cancel();
    sellCryptocurrencySubscription.cancel();
    return super.close();
  }
}
