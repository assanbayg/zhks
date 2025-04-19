// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/chats/data/models/message.dart';
import 'package:zhks/features/chats/data/models/news_message.dart';
import 'package:zhks/features/chats/data/models/vote.dart';
import 'package:zhks/features/chats/presentation/chat_providers.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final votes = ref.watch(votesProvider);
    final supportMessages = ref.watch(supportMessagesProvider);
    final debtMessages = ref.watch(debtMessagesProvider);
    final newsMessages = ref.watch(newsMessagesProvider);

    return Scaffold(
      appBar: const CustomAppBar(label: 'Чаты'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            _ChatCard(
              icon: Icons.poll,
              title: 'Голосования',
              messages: votes,
              location: 'votes',
            ),
            _ChatCard(
              icon: Icons.shield_rounded,
              title: 'Задолженность',
              messages: debtMessages,
              location: 'debts',
            ),
            _ChatCard(
              icon: Icons.campaign_rounded,
              title: 'Новости',
              messages: newsMessages,
              location: 'news',
            ),
            _ChatCard(
              icon: Icons.support_agent,
              title: 'Поддержка',
              messages: supportMessages,
              location: 'support',
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final AsyncValue<List> messages;
  final String location;

  // support - Message
  // debts - Message
  // news - NewsMessage
  // vote - Vote

  const _ChatCard({
    required this.icon,
    required this.title,
    required this.messages,
    this.location = 'news',
  });

  String formatTime(String timeString) {
    try {
      final time = DateTime.parse(timeString);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final messageDate = DateTime(time.year, time.month, time.day);

      if (messageDate == today) {
        return DateFormat('HH:mm').format(time);
      } else if (messageDate == today.subtract(const Duration(days: 1))) {
        return 'Вчера';
      } else {
        return DateFormat('dd.MM.yy').format(time);
      }
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    String latestMessage = '';
    String timeText = '';

    final colors = {
      'support': context.colors.primary.blue,
      'debts': context.colors.primary.orange,
      'news': context.colors.primary.red,
      'votes': context.colors.primary.blue,
    };

    messages.when(
      data: (list) {
        if (list.isNotEmpty) {
          if (location == 'news') {
            final msg = list.last as NewsMessage;
            latestMessage = msg.message;
            timeText = formatTime(msg.createdAt);
          } else if (location == 'message') {
            final msg = list.last as Message;
            latestMessage = msg.message;
            timeText = formatTime(msg.createdAt);
          } else if (location == 'support') {
            final msg = list.last as Message;
            latestMessage = msg.message;
            timeText = formatTime(msg.createdAt);
          } else {
            final msg = list.last as Vote;
            latestMessage = msg.description;
            timeText = formatTime(msg.createdAt);
          }
        } else {
          latestMessage = 'Нет сообщений';
        }
      },
      loading: () => 'Загрузка...',
      error: (e, _) => 'Ошибка загрузки',
    );

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors[location] ?? colors['news'],
        radius: 24,
        child: Icon(icon, color: context.colors.white),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.texts.bodyLargeSemibold),
          Text(timeText, style: TextStyle(color: context.colors.primary.gray)),
        ],
      ),
      subtitle: Text(
        latestMessage,
        style: context.texts.bodySmall.copyWith(
          color: context.colors.primary.gray,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => context.goNamed(location),
    );
  }
}
