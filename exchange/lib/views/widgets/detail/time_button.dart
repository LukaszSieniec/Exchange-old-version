import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String text;

  const TimeButton(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
        padding: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 1.15,
            top: SizeConfig.blockSizeVertical * 1.15),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2.15,
                fontWeight: FontWeight.bold)));
  }
}
