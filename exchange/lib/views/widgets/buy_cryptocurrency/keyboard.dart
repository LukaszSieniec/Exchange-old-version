import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard_button.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {

  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: MyLabels.keyboardLabels.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.0,
            crossAxisCount: 3,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0),
        itemBuilder: (context, index) =>
            KeyboardButton(MyLabels.keyboardLabels[index]));
  }
}
