// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/button_theme_extension.dart';
import 'package:zhks/core/themes/color_palette_extension.dart';
import 'package:zhks/core/themes/text_theme_extension.dart';

// Button Styles
final _primaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(lightColorPalette.primary.blue),
  foregroundColor: WidgetStateProperty.all(lightColorPalette.white),
  minimumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  ),
  elevation: WidgetStateProperty.all(0),
  shadowColor: WidgetStateProperty.all(Colors.transparent),
  textStyle: WidgetStateProperty.all(
    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  ),
);

final _secondaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(lightColorPalette.tertiary.gray),
  foregroundColor: WidgetStateProperty.all(lightColorPalette.black),
  minimumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  ),
  elevation: WidgetStateProperty.all(0),
  shadowColor: WidgetStateProperty.all(Colors.transparent),
  textStyle: WidgetStateProperty.all(
    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  ),
);

// Button Theme Extension
final _lightButtonTheme = ButtonThemeExtension(
  primaryButtonStyle: _primaryButtonStyle,
  secondaryButtonStyle: _secondaryButtonStyle,
);

// Text Theme Extension
final _textStyles = TextThemeExtension(
  titleLarge: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: lightColorPalette.black,
  ),
  titleMedium: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: lightColorPalette.black,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: lightColorPalette.black,
  ),
  bodyLargeSemibold: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: lightColorPalette.black,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: lightColorPalette.black,
  ),
  bodyMedium: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: lightColorPalette.black,
  ),
  bodySmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: lightColorPalette.black,
  ),
  caption: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: lightColorPalette.black,
  ),
);

// no dark theme yet
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'SFProDisplay',
  colorScheme: ColorScheme.fromSeed(seedColor: lightColorPalette.primary.blue),
  primaryColor: lightColorPalette.primary.blue,
  scaffoldBackgroundColor: lightColorPalette.white,
  extensions: [lightColorPalette, _textStyles, _lightButtonTheme],
);
