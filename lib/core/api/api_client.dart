// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'package:zhks/core/storage/token_storage.dart';

class ApiClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiClient(this._tokenStorage) : _dio = Dio() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options
      ..baseUrl = dotenv.env['BASE_URL']!
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..followRedirects = false
      ..validateStatus = (status) => status != null && status < 500;

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _tokenStorage.clearToken();
          }
          handler.next(error);
        },
      ),
    );
  }

  Options _buildOptions(dynamic data) {
    final isMultipart = data is FormData;
    return Options(
      headers: {
        'Content-Type':
            isMultipart ? 'multipart/form-data' : 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) {
    return _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParams,
      options: _buildOptions(data),
    );
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParams,
      options: _buildOptions(data),
    );
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParams,
      options: _buildOptions(data),
    );
  }
}
