// themes.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/button_theme_extension.dart';
import 'package:zhks/core/themes/color_palette_extension.dart';

// Define all your colors here as constants
const primaryBlue = Color(0xFF2f5fec);
const primaryGray = Color.fromRGBO(186, 188, 210, 1);
const secondaryColor = Color(0xFFF4F6FA);
const tertiaryGray = Color.fromRGBO(244, 246, 250, 1);
const textGrayColor = Color.fromRGBO(186, 188, 210, 1);
const backgroundColor = Colors.white;
const surfaceColor = Colors.white;
const textPrimaryColor = Colors.black;
const textSecondaryColor = Colors.black87;
const errorColor = Color(0xFFE53935);
const successColor = Color(0xFF43A047);
const warningColor = Color(0xFFFFA000);

// Create the color palette extension
final _lightColorPalette = ColorPaletteExtension(
  primary: primaryBlue,
  secondary: secondaryColor,
  tertiary: tertiaryGray,
  background: backgroundColor,
  surface: surfaceColor,
  textPrimary: textPrimaryColor,
  textSecondary: textSecondaryColor,
  textGray: textGrayColor,
  error: errorColor,
  success: successColor,
  warning: warningColor,
);

// Button styles using the color palette
final _primaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(primaryBlue),
  foregroundColor: WidgetStateProperty.all(Colors.white),
  minimumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  elevation: WidgetStateProperty.all(0),
  shadowColor: WidgetStateProperty.all(Colors.transparent),
  textStyle: WidgetStateProperty.all(
    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  ),
);

final _secondaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(tertiaryGray),
  foregroundColor: WidgetStateProperty.all(Colors.black87),
  minimumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  elevation: WidgetStateProperty.all(0),
  shadowColor: WidgetStateProperty.all(Colors.transparent),
  textStyle: WidgetStateProperty.all(
    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  ),
);

// Button theme extension
final _lightButtonTheme = ButtonThemeExtension(
  primaryButtonStyle: _primaryButtonStyle,
  secondaryButtonStyle: _secondaryButtonStyle,
);

// Main theme data
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'SFProDisplay',
  colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
  primaryColor: primaryBlue,
  extensions: [_lightButtonTheme, _lightColorPalette],
);
