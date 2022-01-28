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
  final CryptocurrencyRepository _cryptocurrencyRepository;

  final BuyCryptocurrencyBloc _buyCryptocurrencyBloc;
  final SellCryptocurrencyBloc _sellCryptocurrencyBloc;

  late final StreamSubscription _buyCryptocurrencySubscription;
  late final StreamSubscription _sellCryptocurrencySubscription;

  TransactionsBloc(this._cryptocurrencyRepository, this._buyCryptocurrencyBloc,
      this._sellCryptocurrencyBloc)
      : super(const TransactionsState()) {
    on<TransactionsLoaded>(_onTransactionsLoaded);
    on<TransactionsUpdated>(_onTransactionsUpdated);

    void onTransactionsStateChangedByPurchase(BuyCryptocurrencyState state) {
      if (state.buyCryptocurrencyStatus == BuyCryptocurrencyStatus.success) {
        add(TransactionsUpdated(state.transaction!));
      }
    }

    void onTransactionsStateChangedBySale(SellCryptocurrencyState state) {
      if (state.sellCryptocurrencyStatus == SellCryptocurrencyStatus.success) {
        add(TransactionsUpdated(state.transaction!));
      }
    }

    _buyCryptocurrencySubscription = _buyCryptocurrencyBloc.stream
        .listen(onTransactionsStateChangedByPurchase);
    _sellCryptocurrencySubscription =
        _sellCryptocurrencyBloc.stream.listen(onTransactionsStateChangedBySale);
  }

  Future<void> _onTransactionsLoaded(
      TransactionsLoaded event, Emitter<TransactionsState> emit) async {
    emit(state.copyWith(transactionsStatus: TransactionsStatus.loading));
    try {
      final List<Transaction> transactions =
          await _cryptocurrencyRepository.readAllTransactions();

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
      _cryptocurrencyRepository.createTransaction(transaction);

  @override
  Future<void> close() {
    _buyCryptocurrencySubscription.cancel();
    _sellCryptocurrencySubscription.cancel();
    return super.close();
  }
}
