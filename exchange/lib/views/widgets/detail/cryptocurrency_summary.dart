import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptocurrencySummary extends StatelessWidget {
  const CryptocurrencySummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        color: const Color(MyColors.brighterBackground),
        child: Column(children: [
          Expanded(
            child: Row(children: [
            _buildSingleInformation(MyLabels.rank, '#1', isTopLeftRadius: true),
            _buildSingleInformation(MyLabels.maxSupply, '21M'),
            _buildSingleInformation(MyLabels.circulating, 'N/A',
                isTopRightRadius: true)
          ])),
          Expanded(
            child: Row(children: [
              _buildSingleInformation(MyLabels.dayVolume, '\$ 36,99B',
                  flex: 2, isBottomLeftRadius: true),
              _buildSingleInformation(MyLabels.marketCap, '\$ 1,03T',
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
    return Expanded(
        flex: flex,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white10),
                borderRadius: BorderRadius.only(
                    topLeft: isTopLeftRadius
                        ? const Radius.circular(16.0)
                        : const Radius.circular(0),
                    topRight: isTopRightRadius
                        ? const Radius.circular(16.0)
                        : const Radius.circular(0),
                    bottomLeft: isBottomLeftRadius
                        ? const Radius.circular(16.0)
                        : const Radius.circular(0),
                    bottomRight: isBottomRightRadius
                        ? const Radius.circular(16.0)
                        : const Radius.circular(0))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(firstText,
                  style: const TextStyle(
                      color: Color(MyColors.colorText), fontSize: 16.0)),
              Text(secondText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 20.0))
            ])));
  }
}
