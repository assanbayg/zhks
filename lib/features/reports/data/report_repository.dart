// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/reports/data/report.dart';

class ReportRepository {
  final ApiClient _apiClient;

  ReportRepository(this._apiClient);

  Future<List<FinancialReport>> getFinancialReports() async {
    try {
      final response = await _apiClient.get('/api/financial-reports');
      final financialReports =
          (response.data['data'] as List)
              .map((item) => FinancialReport.fromJson(item))
              .toList();

      return financialReports;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<MonthlyReport>> getMonthlyReports() async {
    try {
      final response = await _apiClient.get('/api/monthly-reports');
      final monthlyReports =
          (response.data['data'] as List)
              .map((item) => MonthlyReport.fromJson(item))
              .toList();

      return monthlyReports;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<MonthlyReportDetail> getMonthlyReportDetail(int id) async {
    try {
      final response = await _apiClient.get('/api/monthly-reports/$id');
      final monthlyReportDetail = MonthlyReportDetail.fromJson(
        response.data['data'],
      );

      return monthlyReportDetail;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
