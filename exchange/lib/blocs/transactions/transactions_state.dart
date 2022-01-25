import 'package:equatable/equatable.dart';
import 'package:exchange/models/transaction.dart';

enum TransactionsStatus { initial, loading, success, failure }

class TransactionsState extends Equatable {
  final List<Transaction> transactions;

  final TransactionsStatus transactionsStatus;

  const TransactionsState(
      {this.transactions = const [],
      this.transactionsStatus = TransactionsStatus.initial});

  TransactionsState copyWith(
      {List<Transaction>? transactions,
      TransactionsStatus? transactionsStatus}) {
    return TransactionsState(
        transactions: transactions ?? this.transactions,
        transactionsStatus: transactionsStatus ?? this.transactionsStatus);
  }

  @override
  List<Object> get props => [transactions, transactionsStatus];
}
