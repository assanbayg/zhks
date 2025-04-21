// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/features/chats/data/models/vote.dart';
import 'package:zhks/features/chats/presentation/chat_providers.dart';
import 'package:zhks/features/chats/presentation/widgets/message_permitted.dart';
import 'package:zhks/features/chats/presentation/widgets/vote_widget.dart';

class VotesScreen extends ConsumerWidget {
  const VotesScreen({super.key});

  String _groupByDate(Vote vote) {
    final date = DateTime.parse(vote.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final votes = ref.watch(votesProvider);
    final selectedVotes = ref.watch(selectedVotesProvider);

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Голосования',
        showBackButton: true,
        location: '/chats',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: votes.when(
              data:
                  (data) => GroupedListView<Vote>(
                    items: data,
                    groupBy: _groupByDate,
                    itemBuilder:
                        (vote) => VoteWidget(
                          vote: vote,
                          userSelectedOptionId:
                              vote.userSelectedOptionId ??
                              selectedVotes[vote.id],
                        ),
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
