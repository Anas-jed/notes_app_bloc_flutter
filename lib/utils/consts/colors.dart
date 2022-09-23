import 'package:flutter/material.dart';

class AppColors{
  static const Color white = Color(0xffffffff);
  static const Color whiteDark = Color(0xf0ffffff);
  static const Color maroon = Color(0xff7E0000);

  static Map<int, Color> maroonColorCodes = const {
    50: Color.fromRGBO(128, 0, 0, .1),
    100: Color.fromRGBO(128, 0, 0, .2),
    200: Color.fromRGBO(128, 0, 0, .3),
    300: Color.fromRGBO(128, 0, 0, .4),
    400: Color.fromRGBO(128, 0, 0, .5),
    500: Color.fromRGBO(128, 0, 0, .6),
    600: Color.fromRGBO(128, 0, 0, .7),
    700: Color.fromRGBO(128, 0, 0, .8),
    800: Color.fromRGBO(128, 0, 0, .9),
    900: Color.fromRGBO(128, 0, 0, 1)
  };

  static MaterialColor maroonMaterialColor = MaterialColor(0xff7E0000, maroonColorCodes);
}