// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class DateLabel extends StatelessWidget {
  final String label;
  const DateLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: context.colors.tertiary.gray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
