import 'package:exchange/views/widgets/home/trending_item.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Row(children: [
                const Icon(Icons.attach_money_outlined,
                    size: 40.0, color: Colors.white),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('BTC',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Text('Bitcoin',
                          style:
                          TextStyle(color: Colors.grey, fontSize: 16.0))
                    ])
              ])),
          Expanded(
              flex: 1,
              child: SfSparkLineChart(
                  color: Colors.green,
                  data: exampleData,
                  axisLineWidth: 0)),
          Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('\$59,831,78',
                        style:
                        TextStyle(color: Colors.white, fontSize: 18.0)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getIcon(),
                          const Text('8,02 %',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.0))
                        ])
                  ]))
        ]));
  }
}

Icon getIcon() {
  return exampleData[exampleData.length - 1] >
          exampleData[exampleData.length - 2]
      ? const Icon(Icons.arrow_drop_up_outlined, color: Colors.green, size: 32)
      : const Icon(Icons.arrow_drop_down_outlined, color: Colors.red, size: 32);
}
