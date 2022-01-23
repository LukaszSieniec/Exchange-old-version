import 'package:exchange/blocs/transactions/transactions_bloc.dart';
import 'package:exchange/blocs/transactions/transactions_event.dart';
import 'package:exchange/blocs/transactions/transactions_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/views/widgets/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
      if (state is TransactionsLoadInProgress) {
        return _buildLoading();
      } else if (state is TransactionsLoadSuccess) {
        return _buildBody(state.transactions);
      } else if (state is TransactionsLoadFailure) {}

      return Container();
    });
  }

  Widget _buildBody(List<Transaction> transactions) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          transactions.isNotEmpty
              ? const Text('Transactions',
                  style: TextStyle(
                      color: Color(MyColors.colorText),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold))
              : Container(),
          const SizedBox(height: 16.0),
          transactions.isNotEmpty ? Transactions(transactions) : _buildMessage()
        ]));
  }

  Widget _buildMessage() {
    return const Expanded(
        child: Center(
            child: Text('No transactions',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0))));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
