// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/features/chats/data/models/news_message.dart';
import 'package:zhks/features/chats/presentation/chat_providers.dart';
import 'package:zhks/features/chats/presentation/widgets/message_permitted.dart';
import 'package:zhks/features/chats/presentation/widgets/news_message_widget.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  String _groupByDate(NewsMessage message) {
    final date = DateTime.parse(message.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsMessages = ref.watch(newsMessagesProvider);

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Новости',
        showBackButton: true,
        location: '/chats',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: newsMessages.when(
              data:
                  (data) => GroupedListView<NewsMessage>(
                    items: data,
                    groupBy: _groupByDate,
                    itemBuilder:
                        (message) => NewsMessageWidget(message: message),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (error, stack) =>
                      Center(child: Text('Ошибка загрузки: $error')),
            ),
          ),
          const MessagePermitted(),
        ],
      ),
    );
  }
}
