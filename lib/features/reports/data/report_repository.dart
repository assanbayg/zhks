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

      // Keep for testing purposes
      // return [
      //   FinancialReport(
      //     id: 1,
      //     date: DateTime(2024, 3, 1),
      //     amount: -2000,
      //     description: 'Расходы',
      //   ),
      //   FinancialReport(
      //     id: 2,
      //     date: DateTime(2024, 3, 15),
      //     amount: 5000,
      //     description: 'Платеж за услуги',
      //   ),
      // ];
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

      // Keep for testing purposes
      // return [
      //   MonthlyReport(
      //     id: 1,
      //     title: 'Ежемесячный отчет за Март',
      //     month: '2024-03',
      //   ),
      //   MonthlyReport(
      //     id: 2,
      //     title: 'Ежемесячный отчет за Февраль',
      //     month: '2024-02',
      //   ),
      // ];
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
