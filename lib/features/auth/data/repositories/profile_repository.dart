// Dart imports:
import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/core/data/models/user_profile.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<UserProfile> getUserProfile({bool forceRefresh = false}) async {
    // Check if we need to force refresh the profile
    if (!forceRefresh) {
      final cached = await _getCachedProfile();
      if (cached != null) {
        return cached;
      }
    }

    try {
      final response = await _apiClient.get('/api/profile');
      if (response.data != null && response.data['data'] != null) {
        final profile = UserProfile.fromJson(response.data['data']);
        await _cacheProfile(profile);
        return profile;
      }
      throw Exception('Failed to load profile data');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Method to update the user profile
  Future<void> _cacheProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_profile', jsonEncode(profile.toJson()));
  }

  // Method to retrieve the cached profile
  Future<UserProfile?> _getCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cached_profile');
    if (jsonString == null) return null;

    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProfile.fromJson(map);
    } catch (_) {
      return null;
    }
  }
}
