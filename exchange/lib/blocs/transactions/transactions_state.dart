import 'package:equatable/equatable.dart';
import 'package:exchange/models/transaction.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsLoadInProgress extends TransactionsState {}

class TransactionsLoadSuccess extends TransactionsState {
  final List<Transaction> transactions;

  const TransactionsLoadSuccess([this.transactions = const []]);

  @override
  List<Object> get props => [transactions];
}

class TransactionsLoadFailure extends TransactionsState {}
