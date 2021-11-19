import 'package:exchange/constants/colors.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';

class TrendingItem extends StatelessWidget {
  const TrendingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        margin: const EdgeInsets.all(8.0),
        width: SizeConfig.blockSizeHorizontal * 50.0,
        child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(24.0),
            ),
            elevation: 2,
            color: const Color(MyColors.trendingBackground),
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(children: [
                    const Icon(Icons.attach_money_outlined,
                        size: 48.0, color: Colors.white),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('BTC',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0)),
                          Text('Bitcoin',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20.0))
                        ])
                  ])
                ]))));
  }
}
