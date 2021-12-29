import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_event.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardButton extends StatelessWidget {
  final String label;
  final Function(String) onPressed;

  const KeyboardButton(this.label, {required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => onPressed(label),
        style: OutlinedButton.styleFrom(
            elevation: 4.0,
            backgroundColor: const Color(MyColors.brighterBackground),
            side: BorderSide(color: Colors.grey[800]!, width: 1.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        child: Center(
            child: label != MyLabels.backspace
                ? Text(label,
                    style: const TextStyle(fontSize: 32.0, color: Colors.white))
                : const Icon(Icons.backspace_outlined,
                    color: Colors.white, size: 32.0)));
  }
}
