// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/grouped_list_view.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/reports/data/mock_reports.dart';
import 'package:zhks/features/reports/data/report.dart';
import 'package:zhks/features/reports/presentation/reports_provider.dart';
import 'package:zhks/features/reports/presentation/widgets/housework_report_slider.dart';

class MonthlyReportList extends ConsumerWidget {
  final List<MonthlyReport> reports;
  const MonthlyReportList({super.key, required this.reports});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gray = context.colors.tertiary.gray;

    return GroupedListView<MonthlyReport>(
      items: reports,
      // items: mockMonthlyReports,
      groupBy: (r) => _formatYearLabel(r.month),
      itemBuilder:
          (report) => Card(
            elevation: 0,
            color: gray,
            child: ListTile(
              title: Text(report.title),
              subtitle: Text(report.month),
              trailing: const Icon(Icons.list_rounded),
              onTap: () async {
                final detail = await ref.read(
                  monthlyReportDetailProvider(report.id).future,
                );
                if (context.mounted) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (_) => HouseWorkReportSlider(reportDetail: detail),
                  );
                }
              },
            ),
          ),
    );
  }

  String _formatYearLabel(String date) {
    final now = DateTime.now().year;
    final year = int.tryParse(date.split('-').first) ?? 0;
    return year == now ? 'Этот год' : year.toString();
  }
}
