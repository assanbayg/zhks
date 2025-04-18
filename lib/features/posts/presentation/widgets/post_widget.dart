// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/data/post.dart';
import 'package:zhks/features/posts/presentation/complain_screen.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';

class PostWidget extends ConsumerWidget {
  final Post post;
  final void Function(BuildContext context, Post post)? onCommentsPressed;

  const PostWidget({super.key, required this.post, this.onCommentsPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColors = context.colors.primary;
    final tertiaryColors = context.colors.tertiary;

    final statusColors = {
      "pending": primaryColors.orange,
      "rejected": primaryColors.red,
      "accepted": primaryColors.blue,
    };

    final statusLabel = {
      'pending': "В ожидании",
      "rejected": 'Отклонено',
      'accepted': 'Закрыто',
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ComplainScreen(post: post);
                        },
                      ),
                    );
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
          Text(post.text),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Статус: ', style: TextStyle(color: primaryColors.gray)),
              Text(
                statusLabel[post.status] ?? 'Неизвестно',
                style: TextStyle(
                  color: statusColors[post.status] ?? primaryColors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (post.isLikedByUser) {
                        await ref.read(unlikePostProvider(post.id).future);
                      } else {
                        await ref.read(likePostProvider(post.id).future);
                      }
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
                      if (onCommentsPressed != null) {
                        onCommentsPressed!(context, post);
                      }
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
