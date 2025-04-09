// Flutter imports:
import 'package:flutter/material.dart';

class ColorPaletteExtension extends ThemeExtension<ColorPaletteExtension> {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textGray;
  final Color error;
  final Color success;
  final Color warning;

  ColorPaletteExtension({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textGray,
    required this.error,
    required this.success,
    required this.warning,
  });

  @override
  ThemeExtension<ColorPaletteExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textGray,
    Color? error,
    Color? success,
    Color? warning,
  }) {
    return ColorPaletteExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textGray: textGray ?? this.textGray,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  ThemeExtension<ColorPaletteExtension> lerp(
    ThemeExtension<ColorPaletteExtension>? other,
    double t,
  ) {
    if (other is! ColorPaletteExtension) {
      return this;
    }
    return ColorPaletteExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textGray: Color.lerp(textGray, other.textGray, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
