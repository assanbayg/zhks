// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';
import 'package:zhks/features/posts/presentation/widgets/comment_widget.dart';

class CommentsSheet extends ConsumerStatefulWidget {
  final int postId;
  const CommentsSheet({super.key, required this.postId});

  @override
  ConsumerState<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<CommentsSheet> {
  final _controller = TextEditingController();

  Future<void> _sendComment() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    try {
      await ref.read(createCommentProvider(widget.postId, text).future);
      _controller.clear();
      ref.invalidate(postCommentsProvider(widget.postId));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при отправке комментария: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(postCommentsProvider(widget.postId));
    final colors = context.colors;

    return Container(
      height: 450,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Expanded(
            child: commentsAsync.when(
              data:
                  (comments) =>
                      comments.isEmpty
                          ? Center(
                            child: Text(
                              'Нет комментариев',
                              style: TextStyle(
                                color: colors.primary.gray,
                                fontSize: 16,
                              ),
                            ),
                          )
                          : ListView.separated(
                            itemCount: comments.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 12),
                            itemBuilder:
                                (_, index) =>
                                    CommentWidget(comment: comments[index]),
                          ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Ошибка загрузки: $err')),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Сообщение',
                    hintStyle: TextStyle(color: colors.primary.gray),
                    filled: true,
                    fillColor: colors.tertiary.gray,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _sendComment,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.primary.blue,
                  ),

                  child: Icon(
                    Icons.arrow_upward,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
