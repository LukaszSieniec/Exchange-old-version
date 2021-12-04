import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TrendingItem extends StatelessWidget {
  final Cryptocurrency cryptocurrency;

  const TrendingItem(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        margin:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
        width: SizeConfig.blockSizeHorizontal * 45.0,
        child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(24.0),
            ),
            elevation: 2,
            color: const Color(MyColors.brighterBackground),
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.network(cryptocurrency.image, scale: 8.0),
                              const SizedBox(width: 4.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cryptocurrency.symbol.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                    Text(cryptocurrency.name,
                                        style: const TextStyle(
                                            color: Color(MyColors.colorText),
                                            fontSize: 16.0))
                                  ])
                            ]),
                            _getIcon()
                          ]),
                      Container(
                          margin: const EdgeInsets.all(12.0),
                          child: SfSparkLineChart(
                              color: Colors.green,
                              data: exampleData,
                              axisLineWidth: 0)),
                      Text('\$ ${cryptocurrency.currentPrice}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0))
                    ]))));
  }
}

Icon _getIcon() {
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
