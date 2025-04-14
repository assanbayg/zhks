// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/brand_colors.dart';

class ColorPaletteExtension extends ThemeExtension<ColorPaletteExtension> {
  final BrandColors primary;
  final BrandColors secondary;
  final BrandColors tertiary;
  final Color white;
  final Color black;

  const ColorPaletteExtension({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.white,
    required this.black,
  });

  @override
  ThemeExtension<ColorPaletteExtension> copyWith({
    BrandColors? primary,
    BrandColors? secondary,
    BrandColors? tertiary,
    Color? white,
    Color? black,
  }) {
    return ColorPaletteExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      white: white ?? this.white,
      black: black ?? this.black,
    );
  }

  @override
  ThemeExtension<ColorPaletteExtension> lerp(
    ThemeExtension<ColorPaletteExtension>? other,
    double t,
  ) {
    if (other is! ColorPaletteExtension) return this;
    return ColorPaletteExtension(
      primary: BrandColors.lerp(primary, other.primary, t),
      secondary: BrandColors.lerp(secondary, other.secondary, t),
      tertiary: BrandColors.lerp(tertiary, other.tertiary, t),
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
    );
  }
}

final lightColorPalette = ColorPaletteExtension(
  primary: BrandColors(
    blue: Color(0xFF2F5FEC),
    orange: Color(0xFFF1AE2B),
    green: Color(0xFF42B330),
    red: Color(0xFFE83843),
    gray: Color(0xFFBABCD2),
    darkGray: Color(0xFF3F4145),
    black: Color(0xFF0A0E17),
  ),
  secondary: BrandColors(
    blue: Color(0xFFA6ACF7),
    orange: Color(0xFFE6BF73),
    green: Color(0xFF99CE7C),
    red: Color(0xFFFB9292),
    gray: Color(0xFFD9DDEA),
    darkGray: Color(0xFF779ADE),
    black: Color(0xFF141A24),
  ),
  tertiary: BrandColors(
    blue: Color(0xFFF3F4FF),
    orange: Color(0xFFFFFAEF),
    green: Color(0xFFE8F1E4),
    red: Color(0xFFFFEEEE),
    gray: Color(0xFFF4F6FA),
    darkGray: Color(0xFFDFE7F7),
    black: Color(0xFF000D3D),
  ),
  white: Color(0xFFFFFFFF),
  black: Color(0xFF000000),
);
