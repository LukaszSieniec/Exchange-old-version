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
      : super(const TransactionsState()) {
    on<TransactionsLoaded>(_onTransactionsLoaded);
    on<TransactionsUpdated>(_onTransactionsUpdated);

    void onTransactionsStateChangedByPurchase(BuyCryptocurrencyState state) {
      if (state.buyCryptocurrencyStatus == BuyCryptocurrencyStatus.success) {
        add(TransactionsUpdated(state.transaction!));
      }
    }

    void onTransactionsStateChangedBySale(state) {
      if (state is SellCryptocurrencySuccess) {
        add(TransactionsUpdated(state.transaction));
      }
    }

    buyCryptocurrencySubscription = buyCryptocurrencyBloc.stream
        .listen(onTransactionsStateChangedByPurchase);
    sellCryptocurrencySubscription =
        sellCryptocurrencyBloc.stream.listen(onTransactionsStateChangedBySale);
  }

  Future<void> _onTransactionsLoaded(
      TransactionsLoaded event, Emitter<TransactionsState> emit) async {
    emit(state.copyWith(transactionsStatus: TransactionsStatus.loading));
    try {
      final List<Transaction> transactions =
          await cryptocurrencyRepository.readAllTransactions();

      emit(state.copyWith(
          transactions: transactions,
          transactionsStatus: TransactionsStatus.success));
    } on Exception {
      emit(state.copyWith(transactionsStatus: TransactionsStatus.failure));
    }
  }

  Future<void> _onTransactionsUpdated(
      TransactionsUpdated event, Emitter<TransactionsState> emit) async {
    final List<Transaction> transactions = [
      ...state.transactions,
      event.transaction
    ];

    emit(state.copyWith(transactions: transactions));
    _createTransaction(event.transaction);
  }

  Future<void> _createTransaction(Transaction transaction) =>
      cryptocurrencyRepository.createTransaction(transaction);

  @override
  Future<void> close() {
    buyCryptocurrencySubscription.cancel();
    sellCryptocurrencySubscription.cancel();
    return super.close();
  }
}
