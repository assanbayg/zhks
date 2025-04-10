// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

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
          color: context.colors.tertiary.gray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Positioned(
              left: 24,
              child: Image.asset(flagPath, width: 20, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
