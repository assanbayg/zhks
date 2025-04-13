// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class SettingsCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const SettingsCard({
    super.key,
    required this.label,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: context.colors.tertiary.gray,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 30),
            SizedBox(width: 12),
            Text(label, style: context.texts.bodyLarge),
          ],
        ),
      ),
    );
  }
}
