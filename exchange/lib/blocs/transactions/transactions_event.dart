import 'package:equatable/equatable.dart';
import 'package:exchange/models/transaction.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class TransactionsLoaded extends TransactionsEvent {}

class TransactionsUpdated extends TransactionsEvent {
  final Transaction transaction;

  const TransactionsUpdated(this.transaction);

  @override
  List<Object> get props => [transaction];
}