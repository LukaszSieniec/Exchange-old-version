import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:exchange/views/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CryptocurrencyItem extends StatelessWidget {
  final CryptocurrencyResponse cryptocurrency;

  const CryptocurrencyItem(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(cryptocurrency.id))),
        child: Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1.70,
                bottom: SizeConfig.blockSizeVertical * 1.70,
                left: SizeConfig.blockSizeHorizontal * 2.25,
                right: SizeConfig.blockSizeHorizontal * 2.25),
            child: Row(children: [
              Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cryptocurrency.symbol.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical * 2.80)),
                        Text(cryptocurrency.name,
                            style: TextStyle(
                                color: const Color(MyColors.colorText),
                                fontSize: SizeConfig.blockSizeVertical * 2.25))
                      ])),
              Expanded(
                  flex: 1,
                  child: SfSparkLineChart(
                      color: Colors.green,
                      data: cryptocurrency.sparkline.price
                          .map((number) => number as num)
                          .toList(),
                      axisLineWidth: 0)),
              Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$ ${cryptocurrency.currentPrice}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeVertical * 2.50)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildIcon(),
                              Text('${cryptocurrency.priceChangePercentage24h}',
                                  style: TextStyle(
                                      color: _getColor(),
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2.25))
                            ])
                      ]))
            ])));
  }

  Icon _buildIcon() {
    return cryptocurrency.priceChangePercentage24h > 0
        ? Icon(Icons.arrow_drop_up_outlined,
            color: Colors.green, size: SizeConfig.blockSizeVertical * 4.50)
        : Icon(Icons.arrow_drop_down_outlined,
            color: Colors.red, size: SizeConfig.blockSizeVertical * 4.50);
  }

  Color _getColor() {
    return cryptocurrency.priceChangePercentage24h > 0
        ? Colors.green
        : Colors.red;
  }
}
