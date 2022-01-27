import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  const Message(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Center(
            child: Text(MyLabels.noCryptocurrencies,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0))));
  }
}
