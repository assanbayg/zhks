// Helper to handle API errors

// Package imports:
import 'package:dio/dio.dart';

Exception handleDioError(DioException e) {
  if (e.response != null) {
    // Try to get error message from API response
    final data = e.response?.data;
    if (data != null && data['message'] != null) {
      return Exception(data['message']);
    } else if (data != null && data['errors'] != null) {
      // Handle validation errors
      final errors = data['errors'] as Map;
      final errorMessages = errors.values
          .expand((e) => e is List ? e : [e.toString()])
          .join(', ');
      return Exception(errorMessages);
    }
  }
  // Return error
  return Exception('Произошла ошибка. Повторите попытку позже.');
}
