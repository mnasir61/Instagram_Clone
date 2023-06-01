import 'package:flutter/material.dart';

final primaryColor = Colors.white;
final colorBlue = Color.fromRGBO(0, 97, 224,1);

class Styles {
  //App Colors
  static Color bgColorBlack = Color.fromRGBO(0, 0, 0, 1.0);
  static Color bgColorWhite = Color.fromRGBO(227, 227, 227, 1.0);
  static Color colorWhiteMid = Color.fromRGBO(153, 153, 153, 1);
  static Color secondaryColor = Colors.grey;
  static Color colorGray1 = Color.fromRGBO(115, 111, 111, 1);
  static Color darkGreyColor = Color.fromRGBO(97, 97, 97, 1);
  static Color colorGray2 = Color.fromRGBO(77, 74, 81, 1);
  static Color colorGray3 = Color.fromRGBO(66, 66, 66, 1);
  static Color textColor = Color(0xff3b3b3b);
  static Color colorGray4 = Color.fromRGBO(49, 49, 49, 1);
  static Color colorGray6 = Color.fromRGBO(36, 36, 36, 1);
  static Color colorGray5 = Color.fromRGBO(33, 33, 33, 1);

  // static Color colorDeepOrange = Color.fromRGBO(178, 50, 0, 1.0);
  static Color colorDimBlack = Color.fromRGBO(18, 18, 18, 1);

  static Color colorBlack = Colors.black;
  static Color colorWhite = Colors.white;

  static Color colorGreySameAsText = Colors.grey.shade500;

  //App TextStyles
  static TextStyle textStyle = TextStyle(fontSize: 16, color: textColor);
  static TextStyle headLine = TextStyle(fontSize: 20, color: colorWhite);
  static TextStyle titleLine1 = TextStyle(fontSize: 17, color: colorWhite);
  static TextStyle titleLine2 = TextStyle(fontSize: 14, color: colorWhite);
  static TextStyle titleLine3 = TextStyle(fontSize: 12, color: colorWhite);
  static TextStyle titleLine4 = TextStyle(fontSize: 11, color: colorWhite);
  static TextStyle titleLine5 = TextStyle(fontSize: 11, color: Colors.grey.shade500);
}

Widget verticalSize(double height) {
  return SizedBox(height: height,);
}

Widget horizontalSize(double width) {
  return SizedBox(width: width);
}
