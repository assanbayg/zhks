// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/features/posts/data/zhk.dart';

class ZhkRepository {
  final ApiClient _apiClient;

  ZhkRepository(this._apiClient);

  Future<List<Zhk>> getZhkList() async {
    try {
      final response = await _apiClient.get('/api/zhks');
      final zhkList =
          (response.data['data'] as List)
              .map((item) => Zhk.fromJson(item))
              .toList();
      return zhkList;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response?.data is Map && e.response?.data['message'] != null) {
      return Exception(e.response!.data['message']);
    }
    return Exception('Не удалось загрузить список ЖК.');
  }
}
