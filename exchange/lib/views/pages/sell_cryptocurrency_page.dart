import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/confirm_button.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard.dart';
import 'package:flutter/material.dart';

class SellCryptocurrencyPage extends StatelessWidget {
  const SellCryptocurrencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: SafeArea(
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: const Text('Balance: 1000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold))))),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop())),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(height: 2.0, color: Colors.white),
              const Text('0',
                  style: TextStyle(fontSize: 48.0, color: Colors.white)),
              Container(
                  margin: const EdgeInsets.only(
                      bottom: 16.0, left: 8.0, right: 8.0),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Estimated \$: ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(MyColors.colorText))),
                          Text('200',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ]),
                    const SizedBox(height: 16.0),
                    //const Keyboard(),
                    const SizedBox(height: 32.0),
                    const ConfirmButton()
                  ]))
            ]));
  }
}
