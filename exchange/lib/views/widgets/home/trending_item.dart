import 'package:exchange/constants/colors.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TrendingItem extends StatelessWidget {
  const TrendingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        margin: const EdgeInsets.all(8.0),
        width: SizeConfig.blockSizeHorizontal * 50.0,
        child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(24.0),
            ),
            elevation: 2,
            color: const Color(MyColors.trendingBackground),
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
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
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16.0))
                                  ])
                            ]),
                            getIcon()
                          ]),
                      Container(
                        margin: const EdgeInsets.all(12.0),
                        child: SfSparkLineChart(
                            color: Colors.green,
                            data: exampleData,
                            axisLineWidth: 0),
                      ),
                      const Text('\$ 78,43',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0))
                    ]))));
  }
}

Icon getIcon() {
  return exampleData[exampleData.length - 1] >
          exampleData[exampleData.length - 2]
      ? const Icon(Icons.trending_up_outlined, color: Colors.green, size: 32)
      : const Icon(Icons.trending_down_outlined, color: Colors.red, size: 32);
}

const List<int> exampleData = [
  10,
  6,
  8,
  5,
  11,
  5,
  2,
  7,
  3,
  6,
  8,
  10,
  10,
  6,
  8,
  5,
  11,
  5,
  2,
  7,
  3,
  6,
  8,
  7
];
