import 'package:exchange/blocs/transactions/transactions_bloc.dart';
import 'package:exchange/blocs/transactions/transactions_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:exchange/views/widgets/message.dart';
import 'package:exchange/views/widgets/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
      if (state.transactionsStatus == TransactionsStatus.loading) {
        return buildLoading();
      } else if (state.transactionsStatus == TransactionsStatus.success) {
        return _buildTransactionsBody(state.transactions);
      } else {
        return Container();
      }
    });
  }

  Widget _buildTransactionsBody(List<Transaction> transactions) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          transactions.isNotEmpty
              ? const Text(MyLabels.transactions,
                  style: TextStyle(
                      color: Color(MyColors.colorText),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold))
              : Container(),
          const SizedBox(height: 16.0),
          transactions.isNotEmpty
              ? Transactions(transactions)
              : const Message(MyLabels.noTransactions)
        ]));
  }
}
