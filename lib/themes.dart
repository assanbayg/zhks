// Flutter imports:
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2F5FEC);
const darkPrimaryColor = Color(0xFF264BCC);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'SFProDisplay',
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: 'SFProDisplay',
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
);
