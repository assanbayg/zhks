// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/specialist/data/specialist.dart';

class SpecialistRepository {
  final ApiClient _apiClient;

  SpecialistRepository(this._apiClient);

  Future<List<Specialist>> getAllSpecialists() async {
    try {
      final response = await _apiClient.get('/api/specialists');
      final specialists =
          (response.data['data'] as List)
              .map((item) => Specialist.fromJson(item))
              .toList();

      return specialists;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Specialist> getSpecialistById(int id) async {
    try {
      final response = await _apiClient.get('/api/specialists/$id');
      final monthlyReportDetail = Specialist.fromJson(response.data['data']);

      return monthlyReportDetail;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<Schedule>> getSchedules(int specialistId) async {
    final specialist = await getSpecialistById(specialistId);
    return specialist.schedules!;
  }
}
