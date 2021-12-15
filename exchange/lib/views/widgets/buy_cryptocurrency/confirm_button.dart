import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => debugPrint('Clicked!'),
        style: OutlinedButton.styleFrom(
            elevation: 4.0,
            shape: const StadiumBorder(),
            backgroundColor: const Color(MyColors.brighterBackground)),
        child: const Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: SizedBox(
                width: double.infinity,
                child: Text('Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))));
  }
}
