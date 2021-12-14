import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  const KeyboardButton(this.label, this.isCircularLeft, this.isCircularRight,
      this.onTap, this.iconData,
      {Key? key})
      : super(key: key);

  final String label;

  final bool isCircularLeft;
  final bool isCircularRight;

  final VoidCallback onTap;

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => onTap(),
        style: OutlinedButton.styleFrom(
            backgroundColor: const Color(MyColors.brighterBackground),
            side: const BorderSide(color: Colors.white, width: 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: isCircularLeft
                        ? const Radius.circular(12)
                        : const Radius.circular(0),
                    bottomRight: isCircularRight
                        ? const Radius.circular(12)
                        : const Radius.circular(0)))),
        child: Center(
            child: label != null
                ? Text(label,
                    style: const TextStyle(fontSize: 24, color: Colors.black))
                : Icon(iconData, color: Colors.black)));
  }
}
