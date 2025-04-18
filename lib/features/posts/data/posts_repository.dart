// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/dio_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/posts/data/comment.dart';
import 'package:zhks/features/posts/data/post.dart';

class PostsRepository {
  final ApiClient _apiClient;

  PostsRepository(this._apiClient);

  Future<Map<String, dynamic>> getPosts({int page = 1}) async {
    try {
      final response = await _apiClient.get('/api/posts?page=$page');
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Post> getPostById(int id) async {
    try {
      final response = await _apiClient.get('/api/posts/$id');
      return Post.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> createPost({
    required String text,
    required bool anonymous,
    List<File>? photos,
  }) async {
    try {
      FormData formData = FormData();

      formData.fields.add(MapEntry('text', text));
      formData.fields.add(MapEntry('anonymous', anonymous.toString()));

      if (photos != null && photos.isNotEmpty) {
        for (var photo in photos) {
          final fileName = photo.path.split('/').last;
          formData.files.add(
            MapEntry(
              'photos[]',
              await MultipartFile.fromFile(photo.path, filename: fileName),
            ),
          );
        }
      }

      await _apiClient.post('/api/posts', data: formData);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiClient.delete('/api/posts/$id');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> complainPost(int postId) async {
    try {
      await _apiClient.post('/api/posts/$postId/complain');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<Comment>> getComments(int postId) async {
    try {
      final response = await _apiClient.get('/api/posts/$postId/comments');
      final comments =
          (response.data['data'] as List)
              .map((c) => Comment.fromJson(c))
              .toList();
      return comments;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> createComment(int postId, String text) async {
    try {
      await _apiClient.post(
        '/api/posts/$postId/comments',
        data: {'text': text},
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> deleteComment(int commentId) async {
    try {
      await _apiClient.delete('/api/comments/$commentId');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> likePost(int postId) async {
    try {
      await _apiClient.post('/api/posts/$postId/like');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> unlikePost(int postId) async {
    try {
      await _apiClient.post('/api/posts/$postId/unlike');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> likeComment(int commentId) async {
    try {
      await _apiClient.post('/api/comments/$commentId/like');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> unlikeComment(int commentId) async {
    try {
      await _apiClient.post('/api/comments/$commentId/unlike');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
