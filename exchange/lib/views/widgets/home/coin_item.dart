import 'package:exchange/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white10, width: 2),
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 2,
        color: const Color(MyColors.coinBackground),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: [
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
                        style: TextStyle(color: Colors.grey, fontSize: 16.0))
                  ])
            ])));
  }
}
