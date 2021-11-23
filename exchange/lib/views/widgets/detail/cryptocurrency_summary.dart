import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptocurrencySummary extends StatelessWidget {
  const CryptocurrencySummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(MyColors.brighterBackground),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white10, width: 1),
            borderRadius: BorderRadius.circular(16.0)),
        child: Column(children: [
          Container(
              color: Colors.yellow,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSingleInformation(MyLabels.day, '#1'),
                    _buildSingleInformation(MyLabels.dayVolume, '\$85431,123'),
                    _buildSingleInformation(
                        MyLabels.marketCap, '\$1023492325,12')
                  ])),
          Container(
              color: Colors.green,
              child: Row(children: [
                _buildSingleInformation(MyLabels.maxSupply, '21000000'),
                _buildSingleInformation(MyLabels.circulating, 'N/A')
              ]))
        ]));
  }

  Widget _buildSingleInformation(String firstText, String secondText) {
    return Expanded(
        flex: 1,
        child: Column(children: [
          Text(firstText,
              style: const TextStyle(color: Color(MyColors.colorText))),
          Text(secondText, style: const TextStyle(color: Colors.white))
        ]));
  }
}
