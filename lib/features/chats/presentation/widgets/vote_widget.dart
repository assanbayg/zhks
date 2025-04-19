import 'package:flutter/material.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/chats/data/models/vote.dart';

class VoteWidget extends StatelessWidget {
  final Vote vote;

  const VoteWidget({super.key, required this.vote});

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
                  const Expanded(
                    child: Text(
                      // TODO: take real document
                      'Документ.pdf',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          /// Vote Options
          ...vote.options.map((option) {
            final isSelected = false; // TODO: implement selection logic
            // final isSelected = true;
            //
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),

              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primary.blue : secondary.gray,
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
                                      isSelected ? Colors.white : primary.gray,
                                ),
                            ],
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: option.percentage / 100,
                            backgroundColor:
                                isSelected ? secondary.blue : primary.gray,
                            color: isSelected ? Colors.white : teritary.black,
                            minHeight: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          /// Footer
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
