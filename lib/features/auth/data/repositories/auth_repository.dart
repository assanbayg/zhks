// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/core/storage/token_storage.dart';
import 'package:zhks/features/auth/data/models/resident.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthRepository(this._apiClient, this._tokenStorage);

  // 1. Get code
  Future<bool> requestLoginCode(String email) async {
    try {
      await _apiClient.post('/api/login', data: {'email': email});
      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // 2. Verify code and get token
  Future<String> verifyLoginCode(String email, String code) async {
    try {
      final response = await _apiClient.post(
        '/api/verify-code',
        data: {'email': email, 'code': code},
      );

      final token = response.data['token'];
      if (token != null) {
        await _tokenStorage.saveToken(token);
        return token;
      }
      throw Exception('Invalid token response');
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Registration
  Future<bool> register(Resident resident) async {
    try {
      await _apiClient.post('/api/register', data: resident.toJson());
      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Add roommate
  Future<bool> addRoommate(Resident resident) async {
    try {
      // Send only necessary fields for the сожитель
      final data = {
        'first_name': resident.firstName,
        'last_name': resident.lastName,
        'gender': resident.gender,
        'email': resident.email,
        'phone_number': resident.phoneNumber,
      };

      await _apiClient.post('/api/residents', data: data);
      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Logout -> clear token
  Future<void> logout() async {
    await _tokenStorage.clearToken();
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _tokenStorage.getToken();
    return token != null;
  }
}
