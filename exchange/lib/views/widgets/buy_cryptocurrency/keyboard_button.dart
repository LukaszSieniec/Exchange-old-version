import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final String label;

  const KeyboardButton(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => debugPrint('Clicked $label'),
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
