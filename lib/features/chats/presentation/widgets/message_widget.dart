// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/chats/data/models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(message.createdAt);
    final timeLabel = DateFormat('HH:MM', 'ru').format(createdAt);

    final isUser = message.senderType == 'user';
    return Container(
      margin: EdgeInsets.only(
        bottom: 8,
        right: isUser ? 0 : 64,
        left: isUser ? 64 : 0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:
            isUser ? context.colors.primary.blue : context.colors.tertiary.gray,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.message,
            style: context.texts.bodyLarge.copyWith(
              color: isUser ? context.colors.white : context.colors.black,
            ),
          ),
          Text(
            timeLabel,
            style: context.texts.bodyLarge.copyWith(
              color:
                  isUser
                      ? context.colors.tertiary.blue
                      : context.colors.primary.gray,
            ),
          ),
        ],
      ),
    );
  }
}
