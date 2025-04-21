// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/core/presentation/widgets/message_field.dart';
import 'package:zhks/features/chats/data/models/message.dart';
import 'package:zhks/features/chats/presentation/chat_providers.dart';
import 'package:zhks/features/chats/presentation/widgets/message_widget.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  String _groupByDate(Message message) {
    final date = DateTime.parse(message.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportMessages = ref.watch(supportMessagesProvider);
    final controller = TextEditingController();

    void onSend() {
      if (controller.text.trim().isNotEmpty) {
        final messageText = controller.text;
        // Create a temporary message to show immediately
        // while the API request is in progress
        final tempMessage = Message(
          message: messageText,
          createdAt: DateTime.now().toString(),
          senderType: 'user',
          senderId: null, // This will be set by the server
        );

        // Clear the text field
        controller.clear();

        // Send the message to the server
        ref
            .read(chatRepositoryProvider)
            .sendSupportMessage(messageText)
            .then((_) {
              // Refresh the support messages after sending
              ref.refresh(supportMessagesProvider);
            })
            .catchError((error) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка отправки сообщения: $error')),
              );
            });
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Поддержка',
        showBackButton: true,
        location: '/chats',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: supportMessages.when(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MessageField(onSend: onSend, controller: controller),
          ),
        ],
      ),
    );
  }
}
