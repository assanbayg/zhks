// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/models/report.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class FinancialReportList extends ConsumerWidget {
  final List<FinancialReport> reports;
  const FinancialReportList({super.key, required this.reports});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gray = context.colors.tertiary.gray;

    // группировать их по месяцам
    final grouped = <String, List<FinancialReport>>{};
    for (final report in reports) {
      final label = _formatMonthYear(report.date);
      grouped.putIfAbsent(label, () => []).add(report);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children:
          grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                _buildDateLabel(gray, entry.key),
                const SizedBox(height: 8),
                ...entry.value.map(
                  (r) => Card(
                    elevation: 0,
                    color: gray,
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              r.amount > 0
                                  ? context.colors.primary.blue
                                  : context.colors.primary.red,
                        ),

                        child: Icon(
                          r.amount > 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      title: Text('${r.amount} ₸'),
                      subtitle: Text(
                        r.description,
                        style: context.texts.bodySmall.copyWith(
                          color: context.colors.primary.gray,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildDateLabel(Color background, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label, textAlign: TextAlign.center),
        ),
      ],
    );
  }

  String _formatMonthYear(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month) {
      return 'Этот месяц';
    }

    const monthNames = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];

    return '${monthNames[date.month - 1]} ${date.year}';
  }
}
