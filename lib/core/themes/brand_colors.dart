// Dart imports:
import 'dart:ui';

class BrandColors {
  final Color blue;
  final Color orange;
  final Color green;
  final Color red;
  final Color gray;
  final Color darkGray;
  final Color black;

  const BrandColors({
    required this.blue,
    required this.orange,
    required this.green,
    required this.red,
    required this.gray,
    required this.darkGray,
    required this.black,
  });

  static BrandColors lerp(BrandColors a, BrandColors b, double t) {
    return BrandColors(
      blue: Color.lerp(a.blue, b.blue, t)!,
      orange: Color.lerp(a.orange, b.orange, t)!,
      green: Color.lerp(a.green, b.green, t)!,
      red: Color.lerp(a.red, b.red, t)!,
      gray: Color.lerp(a.gray, b.gray, t)!,
      darkGray: Color.lerp(a.darkGray, b.darkGray, t)!,
      black: Color.lerp(a.black, b.black, t)!,
    );
  }
}
