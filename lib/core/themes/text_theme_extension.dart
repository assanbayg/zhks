// Flutter imports:
import 'package:flutter/material.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final TextStyle headlineStyle;
  final TextStyle titleStyle;
  final TextStyle bodyStyle;
  final TextStyle captionStyle;
  final TextStyle grayTextStyle;

  TextThemeExtension({
    required this.headlineStyle,
    required this.titleStyle,
    required this.bodyStyle,
    required this.captionStyle,
    required this.grayTextStyle,
  });

  @override
  ThemeExtension<TextThemeExtension> copyWith({
    TextStyle? headlineStyle,
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    TextStyle? captionStyle,
    TextStyle? grayTextStyle,
  }) {
    return TextThemeExtension(
      headlineStyle: headlineStyle ?? this.headlineStyle,
      titleStyle: titleStyle ?? this.titleStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      captionStyle: captionStyle ?? this.captionStyle,
      grayTextStyle: grayTextStyle ?? this.grayTextStyle,
    );
  }

  @override
  ThemeExtension<TextThemeExtension> lerp(
    ThemeExtension<TextThemeExtension>? other,
    double t,
  ) {
    if (other is! TextThemeExtension) {
      return this;
    }
    return TextThemeExtension(
      headlineStyle: TextStyle.lerp(headlineStyle, other.headlineStyle, t)!,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t)!,
      captionStyle: TextStyle.lerp(captionStyle, other.captionStyle, t)!,
      grayTextStyle: TextStyle.lerp(grayTextStyle, other.grayTextStyle, t)!,
    );
  }
}
