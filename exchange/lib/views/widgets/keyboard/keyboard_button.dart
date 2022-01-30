import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final String label;
  final Function(String) onPressed;

  const KeyboardButton(this.label, {required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return OutlinedButton(
        onPressed: () => onPressed(label),
        style: OutlinedButton.styleFrom(
            elevation: 4.0,
            backgroundColor: const Color(MyColors.brighterBackground),
            side: BorderSide(color: Colors.grey[800]!, width: 1.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeVertical * 2.25)))),
        child: Center(
            child: label != MyLabels.backspace
                ? Text(label,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 4.50,
                        color: Colors.white))
                : Icon(Icons.backspace_outlined,
                    color: Colors.white,
                    size: SizeConfig.blockSizeVertical * 4.50)));
  }
}
