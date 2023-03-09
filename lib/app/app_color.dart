import 'package:flutter/material.dart';

class AppColor {
  static ColorScheme colorSchemeLight = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );
  static ColorScheme colorSchemeDark = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Colors.blue,
    primaryColorDark: Colors.blue,
    brightness: Brightness.dark,
  );
  static const Color backgroundColor = Color(0xfffafafa);
  static const Color backgroundColorDark = Color(0xff212121);
  static const Color black333 = Color(0xff333333);
  static const Color greyf0f0f0 = Color(0xfff0f0f0);

  static Map<int, List<Color>> novelThemes = {
    0: [
      const Color.fromRGBO(245, 239, 217, 1),
      const Color(0xff301e1b),
    ],
    1: [
      const Color.fromRGBO(248, 247, 252, 1),
      black333,
    ],
    2: [
      const Color.fromRGBO(192, 237, 198, 1),
      Colors.black,
    ],
    3: [
      const Color.fromRGBO(40, 53, 72, 1),
      const Color.fromRGBO(200, 200, 200, 1),
    ],
    4: [
      Colors.black,
      const Color.fromRGBO(200, 200, 200, 1),
    ],
  };
}
