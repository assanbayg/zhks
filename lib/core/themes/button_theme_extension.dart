// Flutter imports:
import 'package:flutter/material.dart';

class ButtonThemeExtension extends ThemeExtension<ButtonThemeExtension> {
  final ButtonStyle primaryButtonStyle;
  final ButtonStyle secondaryButtonStyle;

  ButtonThemeExtension({
    required this.primaryButtonStyle,
    required this.secondaryButtonStyle,
  });

  @override
  ThemeExtension<ButtonThemeExtension> copyWith({
    ButtonStyle? primaryButtonStyle,
    ButtonStyle? secondaryButtonStyle,
  }) {
    return ButtonThemeExtension(
      primaryButtonStyle: primaryButtonStyle ?? this.primaryButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle ?? this.secondaryButtonStyle,
    );
  }

  @override
  ThemeExtension<ButtonThemeExtension> lerp(
    ThemeExtension<ButtonThemeExtension>? other,
    double t,
  ) {
    if (other is! ButtonThemeExtension) {
      return this;
    }
    return ButtonThemeExtension(
      primaryButtonStyle:
          ButtonStyle.lerp(primaryButtonStyle, other.primaryButtonStyle, t)!,
      secondaryButtonStyle:
          ButtonStyle.lerp(
            secondaryButtonStyle,
            other.secondaryButtonStyle,
            t,
          )!,
    );
  }
}
