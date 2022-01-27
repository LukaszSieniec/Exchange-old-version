import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  const Message(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: Text(message,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0))));
  }
}
