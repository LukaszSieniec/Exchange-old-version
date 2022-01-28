import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String text;

  const TimeButton(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)));
  }
}
