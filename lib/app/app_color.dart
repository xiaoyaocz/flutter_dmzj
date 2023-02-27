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
}
