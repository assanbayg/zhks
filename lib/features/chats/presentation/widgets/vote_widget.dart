// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/chats/data/models/vote.dart';
import 'package:zhks/features/chats/presentation/chat_providers.dart';

class VoteWidget extends StatelessWidget {
  final Vote vote;
  final int? userSelectedOptionId;

  const VoteWidget({super.key, required this.vote, this.userSelectedOptionId});

  bool get isEnded {
    final end = DateTime.parse(vote.endDate);
    return DateTime.now().isAfter(end);
  }

  String get daysLeft {
    final end = DateTime.parse(vote.endDate);
    final difference = end.difference(DateTime.now()).inDays;
    return 'До конца голосования: $difference ${difference == 1
        ? 'день'
        : [2, 3, 4].contains(difference)
        ? 'дня'
        : 'дней'}';
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.colors.primary;
    final secondary = context.colors.secondary;
    final teritary = context.colors.tertiary;

    return Container(
      margin: const EdgeInsets.only(right: 32),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: teritary.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(vote.description, style: context.texts.bodyLarge),
          const SizedBox(height: 8),

          if (vote.documentUrl != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: secondary.gray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primary.blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.insert_drive_file_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(Uri.parse(vote.documentUrl!).pathSegments.last),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Vote Options
          ...vote.options.map((option) {
            final isSelected =
                userSelectedOptionId == option.id ||
                (isEnded && option.id == userSelectedOptionId);

            return Consumer(
              builder:
                  (context, ref, child) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),

                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap:
                                isEnded || userSelectedOptionId != null
                                    ? null
                                    : () async {
                                      await ref
                                          .read(submitVoteProvider.notifier)
                                          .submit(vote.id, option.id);

                                      ref
                                          .read(selectedVotesProvider.notifier)
                                          .selectOption(vote.id, option.id);
                                    },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? primary.blue : secondary.gray,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          option.option,
                                          style: TextStyle(
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : primary.black,
                                          ),
                                        ),
                                      ),
                                      if (isEnded)
                                        Text(
                                          '${option.percentage}%',
                                          style: TextStyle(
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : primary.black,
                                          ),
                                        ),
                                      if (!isEnded)
                                        Icon(
                                          isSelected
                                              ? Icons.radio_button_on
                                              : Icons.radio_button_off,
                                          size: 25,
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : primary.gray,
                                        ),
                                    ],
                                  ),
                                  if (isEnded)
                                    Column(
                                      children: [
                                        SizedBox(height: 8),
                                        LinearProgressIndicator(
                                          value: option.percentage / 100,
                                          backgroundColor:
                                              isSelected
                                                  ? secondary.blue
                                                  : primary.gray,
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : teritary.black,
                                          minHeight: 4,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            );
          }),

          // Footer
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              isEnded ? 'Голосование окончено' : daysLeft,
              style: TextStyle(fontSize: 12, color: primary.gray),
            ),
          ),
        ],
      ),
    );
  }
}
