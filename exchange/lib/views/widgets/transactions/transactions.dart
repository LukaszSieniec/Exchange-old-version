import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/transaction.dart';
import 'package:exchange/utils/format.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> transactions;

  const Transactions(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return Tooltip(
                  textStyle: TextStyle(
                      color: const Color(MyColors.colorText),
                      fontSize: SizeConfig.blockSizeVertical * 2.25),
                  decoration: BoxDecoration(
                      color: const Color(MyColors.brighterBackground),
                      border: Border.all(width: 1, color: Colors.white10),
                      borderRadius: BorderRadius.all(Radius.circular(
                          SizeConfig.blockSizeVertical * 2.25))),
                  message: '${formatDate(transactions[index].date)}\n'
                      '${MyLabels.price}: ${transactions[index].cryptocurrencyPrice}',
                  child: Card(
                      elevation: 4,
                      color: const Color(MyColors.brighterBackground),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3.35,
                              top: SizeConfig.blockSizeVertical * 1.70,
                              right: SizeConfig.blockSizeHorizontal * 3.35,
                              bottom: SizeConfig.blockSizeVertical * 1.70),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            SizeConfig.blockSizeVertical * 2.25,
                                        backgroundImage: NetworkImage(
                                            transactions[index].image),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  2.25),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                transactions[index]
                                                    .cryptocurrencySymbol
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.80)),
                                            Text(
                                                transactions[index]
                                                    .cryptocurrencyName,
                                                style: TextStyle(
                                                    color: const Color(
                                                        MyColors.colorText),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.25))
                                          ])
                                    ]),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${transactions[index].type == MyLabels.bought ? '-' : '+'} ${transactions[index].amount} \$',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2.80)),
                                      _buildType(transactions[index].type)
                                    ])
                              ]))));
            }));
  }

  Widget _buildType(String type) {
    return Text(type,
        style: TextStyle(
            color: type == MyLabels.sold ? Colors.red : Colors.green,
            fontSize: SizeConfig.blockSizeVertical * 2.25));
  }
}
