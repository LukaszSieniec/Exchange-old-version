import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/views/pages/buy_cryptocurrency_page.dart';
import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  final CryptocurrencyResponse cryptocurrency;

  const BuyButton(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BuyCryptocurrencyPage(cryptocurrency.id)));
        },
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: Colors.green),
            shape: const StadiumBorder(),
            backgroundColor: const Color(MyColors.brighterBackground)),
        child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: SizedBox(
                width: double.infinity,
                child: Text(
                    '${MyLabels.buy} ${cryptocurrency.name.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))));
  }
}
