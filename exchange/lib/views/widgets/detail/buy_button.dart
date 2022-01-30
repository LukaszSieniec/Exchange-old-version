import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:exchange/views/pages/buy_cryptocurrency_page.dart';
import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  final CryptocurrencyResponse cryptocurrency;

  const BuyButton(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return OutlinedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BuyCryptocurrencyPage(cryptocurrency.id)));
        },
        style: OutlinedButton.styleFrom(
            side: BorderSide(
                width: SizeConfig.blockSizeVertical * 0.30, color: Colors.green),
            shape: const StadiumBorder(),
            backgroundColor: const Color(MyColors.brighterBackground)),
        child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2.25,
                bottom: SizeConfig.blockSizeVertical * 2.25),
            child: SizedBox(
                width: double.infinity,
                child: Text(
                    '${MyLabels.buy} ${cryptocurrency.name.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2.80,
                        fontWeight: FontWeight.bold)))));
  }
}
