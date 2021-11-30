import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class Coins extends StatelessWidget {
  const Coins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _myCoins.length,
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
                                      children: const [
                                        Text('BTC',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0)),
                                        Text('Bitcoin',
                                            style: TextStyle(
                                                color:
                                                    Color(MyColors.colorText),
                                                fontSize: 16.0))
                                      ])
                                ]),
                            const Text('3,54870',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0))
                          ])));
            }));
  }
}

class Coin {
  final String name, symbol;
  final double amount, value;

  Coin(this.name, this.symbol, this.amount, this.value);
}

final List<Coin> _myCoins =
    List.generate(8, (index) => Coin('Bitcoin', 'BTC', 10, 5));
