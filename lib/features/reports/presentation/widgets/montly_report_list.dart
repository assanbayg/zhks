// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/features/reports/data/report.dart';
import 'package:zhks/features/reports/presentation/reports_provider.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/reports/presentation/widgets/housework_report_slider.dart';

class MonthlyReportList extends ConsumerWidget {
  final List<MonthlyReport> reports;
  const MonthlyReportList({super.key, required this.reports});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color gray = context.colors.tertiary.gray;
    final grouped = <String, List<MonthlyReport>>{};
    for (final report in reports) {
      final label = _formatYearLabel(report.month, gray);
      grouped.putIfAbsent(label, () => []).add(report);
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children:
          grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDateLabel(entry.key, gray),
                const SizedBox(height: 8),
                ...entry.value.map(
                  (report) => Card(
                    elevation: 0,
                    color: gray,
                    child: ListTile(
                      title: Text(report.title),
                      subtitle: Text('${report.month} '), // TODO: photo count
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
                            builder:
                                (_) =>
                                    HouseWorkReportSlider(reportDetail: detail),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  String _formatYearLabel(String date, colors) {
    final now = DateTime.now().year;
    final year = int.parse(date.split('-')[0]);
    if (year == now) return 'Этот год';
    return year.toString();
  }

  Widget _buildDateLabel(String label, Color gray) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: gray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
