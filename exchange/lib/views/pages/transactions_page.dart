import 'package:exchange/blocs/transactions/transactions_bloc.dart';
import 'package:exchange/blocs/transactions/transactions_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:exchange/views/widgets/message.dart';
import 'package:exchange/views/widgets/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
        margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 1.15,
            left: SizeConfig.blockSizeHorizontal * 2.25,
            right: SizeConfig.blockSizeHorizontal * 2.25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          transactions.isNotEmpty
              ? Text(MyLabels.transactions,
                  style: TextStyle(
                      color: const Color(MyColors.colorText),
                      fontSize: SizeConfig.blockSizeVertical * 3.35,
                      fontWeight: FontWeight.bold))
              : Container(),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.25),
          transactions.isNotEmpty
              ? Transactions(transactions)
              : const Message(MyLabels.noTransactions)
        ]));
  }
}
