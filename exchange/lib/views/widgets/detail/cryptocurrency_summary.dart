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
          Expanded(
            child: Row(
              children: [
                _buildSingleInformation('e', 'e'),
                _buildSingleInformation('e', 'e'),
                _buildSingleInformation('e', 'e')
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(children: [
                _buildSingleInformation('e', 'e'),
                _buildSingleInformation('e', 'e')
              ]),
            ),
          )
        ]));
  }

  Widget _buildSingleInformation(String firstText, String secondText) {
    return Expanded(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(firstText,
            style: const TextStyle(
                color: Color(MyColors.colorText), fontSize: 16.0)),
        Text(secondText,
            style: const TextStyle(color: Colors.white, fontSize: 20.0))
      ]),
    );
  }
}
