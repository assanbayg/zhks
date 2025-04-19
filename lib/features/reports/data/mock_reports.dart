// Project imports:
import 'package:zhks/features/reports/data/report.dart';

final mockFinancialReports = [
  FinancialReport(
    id: 1,
    date: DateTime.now().subtract(const Duration(days: 2)),
    amount: 12000,
    description: 'Плата за аренду',
  ),
  FinancialReport(
    id: 2,
    date: DateTime.now().subtract(const Duration(days: 4)),
    amount: -5000,
    description: 'Оплата за воду',
  ),
  FinancialReport(
    id: 3,
    date: DateTime.now().subtract(const Duration(days: 40)),
    amount: -8000,
    description: 'Оплата за электричество',
  ),
  FinancialReport(
    id: 4,
    date: DateTime.now().subtract(const Duration(days: 70)),
    amount: 10000,
    description: 'Возврат залога',
  ),
  FinancialReport(
    id: 5,
    date: DateTime.now().subtract(const Duration(days: 90)),
    amount: -15000,
    description: 'Ремонт сантехники',
  ),
];

final mockMonthlyReports = [
  MonthlyReport(id: 1, title: 'Январский отчет', month: '2025-01'),
  MonthlyReport(id: 2, title: 'Февральский отчет', month: '2025-02'),
  MonthlyReport(id: 3, title: 'Мартовский отчет', month: '2025-03'),
  MonthlyReport(id: 4, title: 'Апрельский отчет', month: '2025-04'),
  MonthlyReport(id: 5, title: 'Отчет за прошлый год', month: '2024-12'),
];
