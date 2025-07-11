// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/data/models/post.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';
import 'package:zhks/features/posts/presentation/screens/report_screen.dart';

class PostWidget extends ConsumerWidget {
  final Post post;
  final bool isOwnPost;
  final bool isReport;
  final void Function(BuildContext context, Post post)? onCommentsPressed;

  const PostWidget({
    super.key,
    required this.post,
    required this.isOwnPost,
    this.onCommentsPressed,
    this.isReport = false,
  });

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
              if (!isReport)
                PopupMenuButton(
                  menuPadding: EdgeInsets.zero,
                  color: Colors.white,
                  elevation: 1,
                  onSelected: (value) {
                    if (value == 'report') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ReportScreen(post: post);
                          },
                        ),
                      );
                    }
                    if (value == 'delete') {
                      ref.read(deletePostProvider(post.id).future);
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
                        if (!isOwnPost)
                          const PopupMenuItem<String>(
                            value: 'report',
                            child: Row(
                              children: [
                                Icon(Icons.error_outline_rounded),
                                SizedBox(width: 4),
                                Text('Пожаловаться'),
                              ],
                            ),
                          ),
                        if (isOwnPost)
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline),
                                SizedBox(width: 4),
                                Text('Удалить'),
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
                itemBuilder: (_, index) {
                  final imageUrl = post.photos[index].toString().trim();

                  if (Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.network(imageUrl, fit: BoxFit.contain),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: const Icon(Icons.broken_image),
                    );
                  }
                },
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
          if (!isReport)
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
