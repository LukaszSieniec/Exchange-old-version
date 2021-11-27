import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/pages/detail_page.dart';
import 'package:exchange/views/widgets/home/trending_item.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CryptocurrencyItem extends StatelessWidget {
  const CryptocurrencyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DetailPage())),
        child: Container(
            margin: const EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
            child: Row(children: [
              Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('BTC',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                        Text('Bitcoin',
                            style: TextStyle(
                                color: Color(MyColors.colorText),
                                fontSize: 16.0))
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
                              _getIcon(),
                              const Text('8,02 %',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16.0))
                            ])
                      ]))
            ])));
  }
}

Icon _getIcon() {
  return exampleData[exampleData.length - 1] >
          exampleData[exampleData.length - 2]
      ? const Icon(Icons.arrow_drop_up_outlined, color: Colors.green, size: 32)
      : const Icon(Icons.arrow_drop_down_outlined, color: Colors.red, size: 32);
}
