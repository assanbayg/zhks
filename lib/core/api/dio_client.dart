// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'package:zhks/core/storage/token_storage.dart';

class ApiClient {
  final Dio _dio = Dio();
  final TokenStorage _tokenStorage;

  ApiClient(this._tokenStorage) {
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = dotenv.env['BASE_URL']!;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    // Add PrettyDioLogger interceptor for debugging purposes
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    // Add auth interceptor to inject the token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // TODO: Implement Token expiration later
            await _handleTokenExpiration();
            return handler.reject(error);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleTokenExpiration() async {
    // ...
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) {
    return _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }
}
