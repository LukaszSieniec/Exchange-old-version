import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/wallet/coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(MyColors.background),
            body: Container(
                margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Account balance',
                          style: TextStyle(
                              color: Color(MyColors.colorText),
                              fontSize: 16.0)),
                      const SizedBox(height: 4.0),
                      const Text('\$ 378.12',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24.0),
                      Row(children: [
                        const Expanded(
                            child: Divider(height: 2, color: Colors.white)),
                        Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: const Text('Your Coins',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0))),
                        const Expanded(
                            child: Divider(height: 2, color: Colors.white))
                      ]),
                      const SizedBox(height: 16.0),
                      const Coins()
                    ]))));
  }
}
