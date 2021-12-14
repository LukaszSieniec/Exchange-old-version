import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyCryptocurrency extends StatelessWidget {
  const BuyCryptocurrency({Key? key}) : super(key: key);

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
            body: Column(children: [
              const Divider(height: 2.0, color: Colors.white),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                    Text('250 \$',
                        style: TextStyle(fontSize: 48.0, color: Colors.white)),
                    Text('250 \$',
                        style: TextStyle(fontSize: 48.0, color: Colors.white)),
                    Text('250 \$',
                        style: TextStyle(fontSize: 48.0, color: Colors.white))
                  ])),
              Expanded(child: _buildKeyboard())
            ])));
  }

  Widget _buildKeyboard() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Keyboard());
  }
}
