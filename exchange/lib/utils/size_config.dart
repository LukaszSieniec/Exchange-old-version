import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  static late double _screenWidth;
  static late double _screenHeight;

  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = _screenWidth / 100;
    blockSizeVertical = _screenHeight / 100;
  }
}
