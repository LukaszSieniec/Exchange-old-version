import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:flutter/material.dart';

class Coins extends StatelessWidget {
  final List<Cryptocurrency> cryptocurrencies;

  const Coins(this.cryptocurrencies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: cryptocurrencies.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 4,
                  color: const Color(MyColors.brighterBackground),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(CryptoFontIcons.BTC,
                                      color: Colors.white),
                                  const SizedBox(width: 8.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cryptocurrencies[index].symbol,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0)),
                                        Text(cryptocurrencies[index].name,
                                            style: const TextStyle(
                                                color:
                                                    Color(MyColors.colorText),
                                                fontSize: 16.0))
                                      ])
                                ]),
                            Text('${cryptocurrencies[index].amount}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0))
                          ])));
            }));
  }
}
