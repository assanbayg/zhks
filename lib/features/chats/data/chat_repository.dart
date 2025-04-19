// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/chats/data/models/message.dart';
import 'package:zhks/features/chats/data/models/news_message.dart';
import 'package:zhks/features/chats/data/models/vote.dart';

class ChatRepository {
  final ApiClient _apiClient;

  ChatRepository(this._apiClient);

  // News messages
  Future<List<NewsMessage>> getNewsMessages() async {
    try {
      final response = await _apiClient.get('/api/news-messages');
      final messages =
          (response.data["data"] as List)
              .map((m) => NewsMessage.fromJson(m))
              .toList();

      return messages;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Debt messages
  Future<List<Message>> getDebtMessages() async {
    try {
      final response = await _apiClient.get('/api/debts/messages');
      final messages =
          (response.data["data"] as List)
              .map((m) => Message.fromJson(m))
              .toList();

      return messages;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Support messages
  Future<List<Message>> getSupportMessages() async {
    try {
      final response = await _apiClient.get('/api/support/messages');
      final supportMessages =
          (response.data["data"] as List)
              .map((m) => Message.fromJson(m))
              .toList();

      return supportMessages;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> sendSupportMessage(String message) async {
    try {
      await _apiClient.post('/api/support/send', data: {'message': message});
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Votes
  Future<List<Vote>> getVotes() async {
    try {
      final response = await _apiClient.get('/api/votes');
      final votes =
          (response.data['data'] as List).map((v) => Vote.fromJson(v)).toList();

      return votes;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> submitVote(int voteId, int optionId) async {
    try {
      await _apiClient.post(
        '/api/votes/$voteId/vote',
        data: {'option_id': optionId},
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
