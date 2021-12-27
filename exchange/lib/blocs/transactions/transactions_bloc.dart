import 'package:exchange/blocs/transactions/transactions_event.dart';
import 'package:exchange/blocs/transactions/transactions_state.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final CryptocurrencyRepository cryptocurrencyRepository;

  TransactionsBloc(this.cryptocurrencyRepository)
      : super(TransactionsLoadInProgress()) {
    on<TransactionsLoaded>(_onTransactionsLoaded);
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
}
