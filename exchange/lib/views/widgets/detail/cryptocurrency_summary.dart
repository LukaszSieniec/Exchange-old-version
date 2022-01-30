import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/utils/format.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';

class CryptocurrencySummary extends StatelessWidget {
  final CryptocurrencyResponse cryptocurrency;
  const CryptocurrencySummary(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(SizeConfig.blockSizeVertical * 2.25)),
        color: const Color(MyColors.brighterBackground),
        child: Column(children: [
          Expanded(
            child: Row(children: [
            _buildSingleInformation(MyLabels.rank, '#${cryptocurrency.marketCapRank}', isTopLeftRadius: true),
            _buildSingleInformation(MyLabels.maxSupply, getShortNumber(cryptocurrency.totalSupply)),
            _buildSingleInformation(MyLabels.circulating, getShortNumber(cryptocurrency.circulatingSupply),
                isTopRightRadius: true)
          ])),
          Expanded(
            child: Row(children: [
              _buildSingleInformation(MyLabels.dayVolume, '\$ 36,99B',
                  flex: 2, isBottomLeftRadius: true),
              _buildSingleInformation(MyLabels.marketCap, '\$ ${getShortNumber(cryptocurrency.marketCap)}',
                  flex: 2, isBottomRightRadius: true)
            ])
          )
        ]));
  }

  Widget _buildSingleInformation(String firstText, String secondText,
      {int flex = 1,
      isTopLeftRadius = false,
      isTopRightRadius = false,
      isBottomLeftRadius = false,
      isBottomRightRadius = false}) {
    final double sizeConfig = SizeConfig.blockSizeVertical * 2.25;
    return Expanded(
        flex: flex,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white10),
                borderRadius: BorderRadius.only(
                    topLeft: isTopLeftRadius
                        ? Radius.circular(sizeConfig)
                        : const Radius.circular(0),
                    topRight: isTopRightRadius
                        ? Radius.circular(sizeConfig)
                        : const Radius.circular(0),
                    bottomLeft: isBottomLeftRadius
                        ? Radius.circular(sizeConfig)
                        : const Radius.circular(0),
                    bottomRight: isBottomRightRadius
                        ? Radius.circular(sizeConfig)
                        : const Radius.circular(0))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(firstText,
                  style: TextStyle(
                      color: const Color(MyColors.colorText), fontSize: sizeConfig)),
              Text(secondText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeVertical * 2.80))
            ])));
  }
}
