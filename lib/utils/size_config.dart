import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth; // Width of the screen
  static late double screenHeight; // Height of the screen
  static late double defaultSize; // Default size of the screen
  static late Orientation orientation; // Orientation of the screen

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer user
  return (inputHeight / 812.0) * SizeConfig.screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout height that designer user
  return (inputWidth / 375.0) * SizeConfig.screenWidth;
}
