// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/features/chats/data/models/message.dart';
import 'package:zhks/features/chats/presentation/chat_providers.dart';
import 'package:zhks/features/chats/presentation/widgets/message_permitted.dart';
import 'package:zhks/features/chats/presentation/widgets/message_widget.dart';

class DebtsScreen extends ConsumerWidget {
  const DebtsScreen({super.key});

  String _groupByDate(Message message) {
    final date = DateTime.parse(message.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtMessages = ref.watch(debtMessagesProvider);

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
            child: debtMessages.when(
              data:
                  (data) => GroupedListView<Message>(
                    items: data,
                    groupBy: _groupByDate,
                    itemBuilder: (message) => MessageWidget(message: message),
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
