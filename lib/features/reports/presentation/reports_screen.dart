// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/reports/presentation/reports_provider.dart';
import 'package:zhks/features/reports/presentation/widgets/financial_report_list.dart';
import 'package:zhks/features/reports/presentation/widgets/montly_report_list.dart';
import 'package:zhks/features/reports/presentation/widgets/report_toggle.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  bool isFinanceSelected = true;

  @override
  Widget build(BuildContext context) {
    final financialReports = ref.watch(financialReportsProvider);
    final monthlyReports = ref.watch(monthlyReportsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        label: 'Отчеты',
        showBackButton: true,
        location: '/',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ReportsToggle(
              isFinanceSelected: isFinanceSelected,
              onToggle: (selected) {
                setState(() {
                  isFinanceSelected = selected;
                });
              },
            ),
          ),
          Expanded(
            child:
                isFinanceSelected
                    ? financialReports.when(
                      data: (list) => FinancialReportList(reports: list),
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Ошибка: $e')),
                    )
                    : monthlyReports.when(
                      data: (list) => MonthlyReportList(reports: list),
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Ошибка: $e')),
                    ),
          ),
        ],
      ),
    );
  }
}
