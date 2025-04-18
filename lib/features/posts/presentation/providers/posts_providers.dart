// Dart imports:
import 'dart:io';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/core/api/dio_client.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/posts/data/post.dart';
import 'package:zhks/features/posts/data/posts_repository.dart';

part 'posts_providers.g.dart';

final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  final ApiClient apiClient = ref.watch(apiClientProvider);
  return PostsRepository(apiClient);
});

// Fetch all posts
@riverpod
Future<List<Post>> postsList(ref) async {
  final repo = ref.watch(postsRepositoryProvider);
  return repo.fetchPosts();
}

// Fetch a single post by ID
@riverpod
Future<Post> postById(ref, int postId) async {
  final repo = ref.watch(postsRepositoryProvider);
  return repo.getPostById(postId);
}

// Create a new post
@riverpod
class CreatePost extends _$CreatePost {
  @override
  FutureOr<void> build() {}

  Future<void> create({
    required String text,
    required List<File> photos,
    required bool anonymous,
  }) async {
    final repo = ref.read(postsRepositoryProvider);
    state = const AsyncLoading();
    try {
      await repo.createPost(text: text, photos: photos, anonymous: anonymous);
      state = const AsyncData(null);
      ref.invalidate(postsListProvider); // Refresh post list
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Like a post
@riverpod
Future<void> likePost(ref, int postId) async {
  final repo = ref.read(postsRepositoryProvider);
  await repo.likePost(postId);
  ref.invalidate(postsListProvider); // Refresh list
  ref.invalidate(postByIdProvider(postId)); // Refresh specific post
}

// Unlike a post
@riverpod
Future<void> unlikePost(ref, int postId) async {
  final repo = ref.read(postsRepositoryProvider);
  await repo.unlikePost(postId);
  ref.invalidate(postsListProvider);
  ref.invalidate(postByIdProvider(postId));
}

// Delete a post
@riverpod
Future<void> deletePost(ref, int postId) async {
  final repo = ref.read(postsRepositoryProvider);
  await repo.deletePost(postId);
  ref.invalidate(postsListProvider);
}

// Complain about a post
@riverpod
Future<void> complainPost(ref, int postId) async {
  final repo = ref.read(postsRepositoryProvider);
  await repo.complainPost(postId);
}
