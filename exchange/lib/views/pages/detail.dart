import 'package:exchange/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(MyColors.background),
      body: SafeArea(
          child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.attach_money_outlined,
                            size: 40, color: Colors.white),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('BTC',
                                  style: TextStyle(
                                      color: Color(MyColors.homeColorText),
                                      fontSize: 18.0)),
                              Text('Bitcoin',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold))
                            ])
                      ]),
                      Column(children: const [
                        Text('+1,47%',
                            style:
                                TextStyle(color: Colors.green, fontSize: 18.0)),
                        Text('\$60,359',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold))
                      ])
                    ]),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //Initialize the spark charts widget
                      child: SfSparkLineChart.custom(
                        xValueMapper: (int index) => data[index].time,
                        yValueMapper: (int index) => data[index].price,
                        dataCount: 5,
                      )),
                )
              ]))),
    );
  }
}

class CryptoData {
  CryptoData(this.time, this.price);

  final double time;
  final double price;
}

List<CryptoData> data = [
  CryptoData(1637518184818, 59690.4613496475),
  CryptoData(1637518370661, 59654.18731233439),
  CryptoData(1637518756900, 59750.09657134827),
  CryptoData(1637518953250, 59732.54157998407),
  CryptoData(1637519353880, 59761.20491613129)
];
