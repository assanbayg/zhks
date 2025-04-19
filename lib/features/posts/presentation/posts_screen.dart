// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';
import 'package:zhks/features/posts/presentation/widgets/comment_sheet.dart';
import 'package:zhks/features/posts/presentation/widgets/post_widget.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsListProvider);

    return Scaffold(
      appBar: CustomAppBar(
        label: 'ЖК',
        showBackButton: true,
        location: '/',
        action: IconButton(
          onPressed: () {
            context.goNamed('create-post');
          },
          icon: const Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: postsAsync.when(
          data: (posts) {
            if (posts.isEmpty) {
              return const Center(child: Text('No posts yet'));
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PostWidget(
                    post: post,
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
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) =>
                  Center(child: Text('Error: ${error.toString()}')),
        ),
      ),
    );
  }
}
