// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/posts/data/post.dart';
import 'package:zhks/features/posts/presentation/widgets/comment_sheet.dart';
import 'package:zhks/features/posts/presentation/widgets/post_widget.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'ЖК',
        showBackButton: true,
        location: '/',
        action: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            PostWidget(
              ref: ref,
              post: Post(
                id: 1,
                user: null, // simulates anonymous post
                text: 'Анонимный пост: проблема с парковкой у 2-го подъезда.',
                status: 'В ожидании',
                photos: [],
                likesCount: 7,
                commentsCount: 3,
                createdAt:
                    DateTime.now()
                        .subtract(const Duration(days: 1))
                        .toString()
                        .split(' ')[0],
                isLikedByUser: false,
              ),
              onCommentsPressed: (context, post) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => CommentsSheet(postId: post.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
