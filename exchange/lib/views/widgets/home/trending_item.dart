import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TrendingItem extends StatelessWidget {
  final CryptocurrencyResponse cryptocurrency;

  const TrendingItem(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
        margin: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 1.10,
            top: SizeConfig.blockSizeVertical * 1.15,
            right: SizeConfig.blockSizeHorizontal * 1.10,
            bottom: SizeConfig.blockSizeVertical * 1.15),
        width: SizeConfig.blockSizeHorizontal * 50.0,
        child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeVertical * 3.35),
            ),
            elevation: 2,
            color: const Color(MyColors.brighterBackground),
            child: Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2.25,
                  top: SizeConfig.blockSizeVertical * 1.15,
                  right: SizeConfig.blockSizeHorizontal * 2.25,
                  bottom: SizeConfig.blockSizeVertical * 1.15,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              CircleAvatar(
                                radius: SizeConfig.blockSizeVertical * 2.25,
                                backgroundImage:
                                    NetworkImage(cryptocurrency.image),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1.65),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cryptocurrency.symbol.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.80)),
                                    Text(cryptocurrency.name,
                                        style: TextStyle(
                                            color:
                                                const Color(MyColors.colorText),
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.25))
                                  ])
                            ]),
                            _buildIcon(cryptocurrency)
                          ]),
                      Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3.35,
                              top: SizeConfig.blockSizeVertical * 1.70,
                              right: SizeConfig.blockSizeHorizontal * 3.35,
                              bottom: SizeConfig.blockSizeVertical * 1.70),
                          child: SfSparkLineChart(
                              color: Colors.green,
                              data: cryptocurrency.sparkline.price
                                  .map((number) => number as num)
                                  .toList(),
                              axisLineWidth: 0)),
                      Text('\$ ${cryptocurrency.currentPrice}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 2.80))
                    ]))));
  }
}

Icon _buildIcon(CryptocurrencyResponse cryptocurrency) {
  return cryptocurrency
              .sparkline.price[cryptocurrency.sparkline.price.length - 1] >
          cryptocurrency
              .sparkline.price[cryptocurrency.sparkline.price.length - 2]
      ? Icon(Icons.trending_up_outlined,
          color: Colors.green, size: SizeConfig.blockSizeVertical * 4.50)
      : Icon(Icons.trending_down_outlined,
          color: Colors.red, size: SizeConfig.blockSizeVertical * 4.50);
}
