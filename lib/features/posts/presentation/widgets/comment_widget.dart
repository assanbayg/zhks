// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/data/comment.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';

class CommentWidget extends ConsumerWidget {
  final int postId;
  final Comment comment;
  const CommentWidget({super.key, required this.comment, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColors = context.colors.primary;
    final tertiaryColors = context.colors.tertiary;

    final isAnonymous = comment.user == null;
    final formattedDate = DateFormat(
      'dd.MM.yy',
    ).format(DateTime.parse(comment.createdAt));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(radius: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAnonymous
                    ? 'Анонимно'
                    : 'Кв. ${comment.user!.apartmentNumber}, под. ${comment.user!.entranceNumber}',
                style: context.texts.bodyLargeSemibold,
              ),
              const SizedBox(height: 4),
              Text(comment.text),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: context.texts.bodySmall.copyWith(
                      color: primaryColors.gray,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (comment.isLikedByUser) {
                        await ref.read(
                          unlikeCommentProvider((
                            postId: postId,
                            commentId: comment.id,
                          )).future,
                        );
                      } else {
                        await ref.read(
                          likeCommentProvider((
                            postId: postId,
                            commentId: comment.id,
                          )).future,
                        );
                      }
                    },
                    icon: Icon(
                      comment.isLikedByUser
                          ? Icons.favorite
                          : Icons.favorite_outline,
                    ),
                    label: Text(comment.likesCount.toString()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          comment.isLikedByUser
                              ? tertiaryColors.red
                              : tertiaryColors.gray,
                      foregroundColor:
                          comment.isLikedByUser
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
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
