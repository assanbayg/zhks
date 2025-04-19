// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/features/chats/data/mock/mock_news_messages.dart';
import 'package:zhks/features/chats/data/models/news_message.dart';
import 'package:zhks/features/chats/presentation/widgets/message_permitted.dart';
import 'package:zhks/features/chats/presentation/widgets/news_message_widget.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  String _groupByDate(NewsMessage message) {
    final date = DateTime.parse(message.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'Задолженность',
        showBackButton: true,
        location: '/chats',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GroupedListView<NewsMessage>(
              items: mockNewsMessages,
              groupBy: _groupByDate,
              itemBuilder: (message) => NewsMessageWidget(message: message),
            ),
          ),
          const MessagePermitted(),
        ],
      ),
    );
  }
}
