import 'package:exchange/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinSummary extends StatelessWidget {
  const CoinSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(MyColors.trendingBackground),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white10, width: 1),
            borderRadius: BorderRadius.circular(16.0)),
        child: Column(children: [
          Container(
              color: Colors.yellow,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInformation('Rank', '#1'),
                    _buildInformation('Day volume', '\$85431,123'),
                    _buildInformation('Market Cap', '\$1023492325,12')
                  ])),
          Container(
            color: Colors.green,
            child: Row(children: [
              _buildInformation('Max Supply', '21000000'),
              _buildInformation('Circulating', 'N/A')
            ]),
          )
        ]));
  }

  Widget _buildInformation(String firstText, String secondText) {
    return Expanded(
        flex: 1,
        child: Column(children: [
          Text(firstText,
              style: const TextStyle(color: Color(MyColors.homeColorText))),
          Text(secondText, style: const TextStyle(color: Colors.white))
        ]));
  }
}
