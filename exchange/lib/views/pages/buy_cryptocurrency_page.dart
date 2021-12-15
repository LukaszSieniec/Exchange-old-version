import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/confirm_button.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyCryptocurrencyPage extends StatelessWidget {
  const BuyCryptocurrencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(MyColors.background),
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: const Text('\$ 378.12',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold)))),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Divider(height: 2.0, color: Colors.white),
                  Container(
                      margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Column(children: [
                        const Text('250 \$',
                            style:
                                TextStyle(fontSize: 48.0, color: Colors.white)),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Estimated BTC',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white)),
                              Text('0,0871',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white))
                            ]),
                        const Divider(height: 2.0, color: Colors.white)
                      ])),
                  Container(
                      margin: const EdgeInsets.only(
                          bottom: 16.0, left: 8.0, right: 8.0),
                      child: Column(children: const [
                        Keyboard(),
                        SizedBox(height: 32.0),
                        ConfirmButton()
                      ]))
                ])));
  }
}
