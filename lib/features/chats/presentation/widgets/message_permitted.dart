// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class MessagePermitted extends StatelessWidget {
  const MessagePermitted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.tertiary.gray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('Сообщения в этом чате запрещены'),
    );
  }
}
