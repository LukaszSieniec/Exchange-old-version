import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  const Message(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Expanded(
        child: Center(
            child: Text(message,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 2.50))));
  }
}
