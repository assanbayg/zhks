// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/auth/data/user_profile.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<UserProfile> getUserProfile() async {
    try {
      final response = await _apiClient.get('/api/profile');

      if (response.data != null && response.data['data'] != null) {
        return UserProfile.fromJson(response.data['data']);
      }

      throw Exception('Failed to load profile data');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
