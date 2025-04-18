// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/data/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final primaryColors = context.colors.primary;
    final tertiaryColors = context.colors.tertiary;

    final statusColors = {
      "В ожидании": primaryColors.orange,
      "Отклонено": primaryColors.red,
      "Закрыто": primaryColors.blue,
    };

    String formatDate(String dateStr) {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat('dd.MM.yy', 'ru_RU');
      return formatter.format(date);
    }

    final isAnonymous = post.user == null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tertiaryColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isAnonymous
                    ? 'Анонимно'
                    : 'Квартира ${post.user!.apartmentNumber}, под. ${post.user!.entranceNumber}',
                style: context.texts.bodyLargeSemibold,
              ),
              PopupMenuButton(
                menuPadding: EdgeInsets.zero,
                color: Colors.white,
                elevation: 1,
                onSelected: (value) {
                  if (value == 'report') {
                    // TODO: navigate to POST /posts/{post_id}/complain
                  }
                },
                icon: const Icon(Icons.more_horiz_rounded),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: tertiaryColors.gray),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                itemBuilder:
                    (_) => [
                      const PopupMenuItem<String>(
                        value: 'report',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error_outline_rounded),
                            SizedBox(width: 4),
                            Text('Report'),
                          ],
                        ),
                      ),
                    ],
              ),
            ],
          ),

          // Photos
          if (post.photos.isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 64,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: post.photos.length,
                itemBuilder:
                    (_, index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.file(post.photos[index], fit: BoxFit.cover),
                    ),
              ),
            ),
          ],

          const SizedBox(height: 8),

          // Text
          Text(post.text),
          const SizedBox(height: 8),

          // Status
          Row(
            children: [
              Text('Статус: ', style: TextStyle(color: primaryColors.gray)),
              Text(
                post.status,
                style: TextStyle(
                  color: statusColors[post.status] ?? primaryColors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: like/unlike logic
                    },
                    icon: Icon(
                      post.isLikedByUser
                          ? Icons.favorite
                          : Icons.favorite_outline,
                    ),
                    label: Text(post.likesCount.toString()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          post.isLikedByUser
                              ? tertiaryColors.red
                              : tertiaryColors.gray,
                      foregroundColor:
                          post.isLikedByUser
                              ? primaryColors.red
                              : primaryColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: open BottomModalSheet with comments
                    },
                    icon: const Icon(Icons.forum_outlined),
                    label: Text(post.commentsCount.toString()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tertiaryColors.gray,
                      foregroundColor: primaryColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              Text(
                formatDate(post.createdAt),
                style: TextStyle(color: primaryColors.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
