// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/features/reports/data/report.dart';
import 'package:zhks/features/reports/data/report_repository.dart';

part 'reports_provider.g.dart';

// Провайдеры для репозитория
@riverpod
ReportRepository reportRepository(ref) {
  return ReportRepository();
}

// чтобы получить финансовые
@riverpod
Future<List<FinancialReport>> financialReports(ref) {
  final repo = ref.watch(reportRepositoryProvider);
  return repo.getFinancialReports();
}

// чтобы получить ежемесячные
@riverpod
Future<List<MonthlyReport>> monthlyReports(ref) {
  final repo = ref.watch(reportRepositoryProvider);
  return repo.getMonthlyReports();
}

// чтобы получить ежемесячные, но с побольше инфой
@riverpod
Future<MonthlyReportDetail> monthlyReportDetail(ref, int id) {
  final repo = ref.watch(reportRepositoryProvider);
  return repo.getMonthlyReportDetail(id);
}
