// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/core/presentation/widgets/message_field.dart';
import 'package:zhks/features/chats/data/mock/mock_messages.dart';
import 'package:zhks/features/chats/data/models/message.dart';
import 'package:zhks/features/chats/presentation/widgets/message_widget.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  String _groupByDate(Message message) {
    final date = DateTime.parse(message.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    void onSend() {
      // Handle sending the message
      print('Message sent: ${controller.text}');
      controller.clear();
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
            child: GroupedListView<Message>(
              items: mockMessages,
              groupBy: _groupByDate,
              itemBuilder: (message) => MessageWidget(message: message),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MessageField(onSend: onSend, controller: controller),
          ),
        ],
      ),
    );
  }
}
