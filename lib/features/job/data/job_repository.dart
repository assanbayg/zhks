// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/job/data/job.dart';

class JobRepository {
  final ApiClient _apiClient;

  JobRepository(this._apiClient);

  Future<List<Job>> getJobs() async {
    // return mockJobs;
    try {
      final response = await _apiClient.get('/api/jobs');
      final jobs =
          (response.data['data'] as List)
              .map((item) => Job.fromJson(item))
              .toList();

      return jobs;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
