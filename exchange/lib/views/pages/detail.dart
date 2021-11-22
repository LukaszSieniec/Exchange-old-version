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
                              style: TextStyle(
                                  color: Colors.green, fontSize: 18.0)),
                          Text('\$60,359',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold))
                        ])
                      ]),
                  Expanded(
                      flex: 3,
                      child: Container(
                          margin: const EdgeInsets.only(top: 32.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white10, width: 1),
                                  borderRadius: BorderRadius.circular(16.0)),
                              elevation: 2,
                              color: const Color(MyColors.trendingBackground),
                              child: Column(children: [
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 16.0),
                                        child: SfSparkLineChart.custom(
                                            xValueMapper: (index) =>
                                                coinsData[index].time,
                                            yValueMapper: (index) =>
                                                coinsData[index].price,
                                            dataCount: coinsData.length,
                                            color: Colors.green,
                                            axisLineWidth: 0))),
                                DefaultTabController(
                                    length: 6,
                                    initialIndex: 0,
                                    child: TabBar(
                                        indicator: const UnderlineTabIndicator(
                                            borderSide: BorderSide(
                                                width: 3.0,
                                                color: Color(0xFFFF773D)),
                                            insets: EdgeInsets.symmetric(
                                                horizontal: 16.0)),
                                        onTap: (value) => debugPrint(
                                            'Selected value: $value'),
                                        tabs: [
                                          _buildTimeButton('D'),
                                          _buildTimeButton('W'),
                                          _buildTimeButton('M'),
                                          _buildTimeButton('3M'),
                                          _buildTimeButton('Y'),
                                          _buildTimeButton('All')
                                        ]))
                              ])))),
                  Expanded(flex: 4, child: Container())
                ]))));
  }

  Widget _buildTimeButton(String text) {
    return Text(text,
        style: const TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold));
  }
}

class CoinData {
  const CoinData(this.time, this.price);

  final int time;
  final double price;
}

const List<CoinData> coinsData = [
  CoinData(1637529443830, 59785.88707927606),
  CoinData(1637529443830, 59785.88707927606),
  CoinData(1637529843709, 59755.79522398186),
  CoinData(1637530067007, 59763.253314338814),
  CoinData(1637530067007, 59763.253314338814),
  CoinData(1637530472420, 59780.79902053801),
  CoinData(1637530664017, 59884.16762029886),
  CoinData(1637531018318, 59868.582469010966),
  CoinData(1637531399027, 59755.082063516296),
  CoinData(1637531600125, 59784.55987917839),
  CoinData(1637531962313, 59724.225446220335),
  CoinData(1637532195996, 59745.319183421925)
];
