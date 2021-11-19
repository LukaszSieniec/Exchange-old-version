import 'package:exchange/constants/colors.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrendingItem extends StatelessWidget {
  const TrendingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        padding: const EdgeInsets.all(8.0),
        width: SizeConfig.blockSizeHorizontal * 50.0,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 2,
            color: const Color(MyColors.trendingBackground),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                const Icon(Icons.attach_money_outlined),
                Column(children: const [
                  Text(
                    'BTC',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text('Bitcoin', style: TextStyle(color: Colors.white))
                ])
              ])
            ])));
  }
}
