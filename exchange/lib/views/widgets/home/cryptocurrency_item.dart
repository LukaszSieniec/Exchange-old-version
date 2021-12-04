import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/views/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CryptocurrencyItem extends StatelessWidget {
  final Cryptocurrency cryptocurrency;

  const CryptocurrencyItem(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailPage())),
        child: Container(
            margin: const EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
            child: Row(children: [
              Expanded(
                  flex: 2,
                  child: Column(
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
                      ])),
              Expanded(
                  flex: 1,
                  child: SfSparkLineChart(
                      color: Colors.green,
                      data: cryptocurrency.price
                          .map((number) => number as num)
                          .toList(),
                      axisLineWidth: 0)),
              Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$ ${cryptocurrency.currentPrice}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18.0)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildIcon(),
                              Text('${cryptocurrency.priceChangePercentage24h}',
                                  style: TextStyle(
                                      color: _getColor(), fontSize: 16.0))
                            ])
                      ]))
            ])));
  }

  Icon _buildIcon() {
    return cryptocurrency.priceChangePercentage24h > 0
        ? const Icon(Icons.arrow_drop_up_outlined,
            color: Colors.green, size: 32)
        : const Icon(Icons.arrow_drop_down_outlined,
            color: Colors.red, size: 32);
  }

  Color _getColor() {
    return cryptocurrency.priceChangePercentage24h > 0
        ? Colors.green
        : Colors.red;
  }
}
