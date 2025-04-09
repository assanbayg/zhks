// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/color_palette_extension.dart';

class SelectLangButton extends StatelessWidget {
  final String flagPath;
  final String label;
  final VoidCallback onTap;

  const SelectLangButton({
    super.key,
    required this.flagPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Theme.of(context).extension<ColorPaletteExtension>()?.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            // Flag on the left
            Positioned(
              left: 16,
              child: Image.asset(
                flagPath,
                width: 30,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
