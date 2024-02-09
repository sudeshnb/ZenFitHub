library app_colors;

import 'package:flutter/material.dart';

class AppColor {
  static Color black = const Color(0xFF000000);
  static Color transparent = Colors.transparent;
  static Color red = Colors.red;

  static Color white = const Color(0xFFFFFFFF);

  static Color green = const Color(0XFF8BC83F);

  // DeepOrange
  // Orange
  static Color orange700 = const Color(0XFFD38002);
  static Color deepYellow = const Color(0XFFFBBC05);
  static Color deepOrange = const Color(0XFFFF805E);

  static Color whiteShade = white.withOpacity(0.3);

  // BlueGray
  static Color blueGray50 = const Color(0XFFE9ECEF);
  Color get blueGray500 => const Color(0XFF707A89);
  Color get blueGray800 => const Color(0XFF234F68);
  static Color blueGray900 = const Color(0XFF3A4750);

  // Gray

  Color get gray50 => const Color(0XFFFCFCFC);
  static Color gray600 = const Color(0XFF707070);
  static Color gray100 = const Color(0XFFF5F5F5);
  static Color gray400 = const Color(0XFFBCBCBC);
  static Color gray700 = const Color(0XFF696969);

  // Indigo
  static Color indigo500 = const Color(0XFF4267B2);

  // Amber
  static Color amber500 = const Color(0XFFFABC06);
  static Color amber700 = const Color(0XFFF6A010);
}
