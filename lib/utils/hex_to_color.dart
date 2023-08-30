import 'package:flutter/material.dart';

class HexToColor {
  static const Color mainColor = Color(0xffFF6600);
  static const Color light = Color(0xffFFffff);
  
  static const Color error = Color(0xffff0000);

  static const Color greenColor = Color(0xff14A23C);
  static const Color blackColor = Color(0xff263238);
  static const Color greyTextFieldColor = Color(0xffDCDCDC);
  static const Color redContainerColor = Color(0xffFFF6EE);
  static const Color greenContainerColor = Color(0xffEFFFEE);
  static const Color blueColor = Color(0xff5B7FFF);
  static const Color blueBackgroundColor = Color(0xffEEF1FF);
  static const Color redBackgroundColor = Color(0xffFFEEEE);
  static const Color blueWhiteBackgroundColor = Color(0xffEEEFFF);
  static const Color blueWhiteColor = Color(0xff3036C3);
}

// Color hexToColor(String hex) {
//   assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

//   return Color(int.parse(hex.substring(1), radix: 16) +
//       (hex.length == 7 ? 0xFF000000 : 0x00000000));
// }
