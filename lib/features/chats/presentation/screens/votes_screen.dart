// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/features/chats/data/mock_votes.dart';
import 'package:zhks/features/chats/data/models/vote.dart';
import 'package:zhks/features/chats/presentation/widgets/message_permitted.dart';

class VotesScreen extends StatelessWidget {
  const VotesScreen({super.key});

  String _groupByDate(Vote vote) {
    final date = DateTime.parse(vote.createdAt);
    return DateFormat('d.MM.yy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context) {
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
            child: GroupedListView<Vote>(
              items: mockVotes,
              groupBy: _groupByDate,
              itemBuilder:
                  // TODO: build proper widget
                  (vote) => Card(
                    child: ListTile(
                      title: Text(vote.description),
                      subtitle: Text('До ${vote.endDate}'),
                      onTap: () {},
                    ),
                  ),
            ),
          ),
          const MessagePermitted(),
        ],
      ),
    );
  }
}
