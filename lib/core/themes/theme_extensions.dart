// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/button_theme_extension.dart';
import 'package:zhks/core/themes/color_palette_extension.dart';
import 'package:zhks/core/themes/text_theme_extension.dart';

extension ThemeX on BuildContext {
  ColorPaletteExtension get colors =>
      Theme.of(this).extension<ColorPaletteExtension>()!;
  TextThemeExtension get texts =>
      Theme.of(this).extension<TextThemeExtension>()!;
  ButtonThemeExtension get buttons =>
      Theme.of(this).extension<ButtonThemeExtension>()!;
}
