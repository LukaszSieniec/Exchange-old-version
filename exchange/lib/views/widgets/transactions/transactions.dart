import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> transactions;

  const Transactions(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return Tooltip(
                  textStyle: const TextStyle(
                      color: Color(MyColors.colorText), fontSize: 16.0),
                  decoration: BoxDecoration(
                      color: const Color(MyColors.brighterBackground),
                      border: Border.all(width: 1, color: Colors.white10),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0))),
                  message: '${formatDate(transactions[index].date)}\n'
                      'Price: ${transactions[index].cryptocurrencyPrice}',
                  child: Card(
                      elevation: 4,
                      color: const Color(MyColors.brighterBackground),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 16.0,
                                        backgroundImage: NetworkImage(
                                            transactions[index].image),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                transactions[index]
                                                    .cryptocurrencySymbol
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0)),
                                            Text(
                                                transactions[index]
                                                    .cryptocurrencyName,
                                                style: const TextStyle(
                                                    color: Color(
                                                        MyColors.colorText),
                                                    fontSize: 16.0))
                                          ])
                                    ]),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${transactions[index].type == MyLabels.bought ? '-' : '+'} ${transactions[index].amount} \$',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0)),
                                      _buildType(transactions[index].type)
                                    ])
                              ]))));
            }));
  }

  Widget _buildType(String type) {
    return Text(type,
        style: TextStyle(
            color: type == MyLabels.sold ? Colors.red : Colors.green,
            fontSize: 16.0));
  }
}
