// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/chats/data/models/news_message.dart';

class NewsMessageWidget extends StatelessWidget {
  final NewsMessage message;
  const NewsMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(message.createdAt);
    final timeLabel = DateFormat('HH:MM', 'ru').format(createdAt);

    return Container(
      margin: EdgeInsets.only(bottom: 8, right: 64),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.tertiary.gray,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.message,
            style: context.texts.bodyLarge.copyWith(
              color: context.colors.black,
            ),
          ),
          Text(
            timeLabel,
            style: context.texts.bodyLarge.copyWith(
              color: context.colors.primary.gray,
            ),
          ),
        ],
      ),
    );
  }
}
