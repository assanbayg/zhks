// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/job/data/job.dart';
import 'package:zhks/features/job/presentation/job_providers.dart';
import 'package:zhks/features/job/presentation/job_widget.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Работы',
        showBackButton: true,
        location: '/account',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: jobsAsync.when(
          data: (jobs) {
            final groupedJobs = _groupJobsByMonth(jobs);

            if (groupedJobs.isEmpty) {
              return const Center(child: Text('Запланированных работ нет'));
            }

            return ListView.builder(
              itemCount: groupedJobs.length,
              itemBuilder: (context, index) {
                final entry = groupedJobs.entries.elementAt(index);
                final monthTitle = entry.key;
                final monthJobs = entry.value;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.tertiary.gray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(monthTitle, textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: monthJobs.length,
                      itemBuilder: (context, i) {
                        final job = monthJobs[i];

                        return JobWidget(job: job);
                      },
                    ),
                  ],
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stack) =>
                  Center(child: Text('Ошибка загрузки заказов: $error')),
        ),
      ),
    );
  }

  Map<String, List<Job>> _groupJobsByMonth(List<Job> jobs) {
    final now = DateTime.now();
    final Map<String, List<Job>> grouped = {};

    // First, separate upcoming jobs
    final List<Job> upcoming =
        jobs
            .where(
              (job) =>
                  job.serviceRequest.requestedDate.isAfter(now) ||
                  (job.serviceRequest.requestedDate.year == now.year &&
                      job.serviceRequest.requestedDate.month == now.month &&
                      job.serviceRequest.requestedDate.day == now.day &&
                      _parseTime(
                        job.serviceRequest.requestedTime,
                      ).isAfter(TimeOfDay.now())),
            )
            .toList();

    if (upcoming.isNotEmpty) {
      grouped['Запланированные'] = upcoming;
    }

    // Then group by months
    final List<Job> pastJobs =
        jobs.where((job) => !upcoming.contains(job)).toList();
    final formatter = DateFormat('MMMM yyyy', 'ru_RU');

    for (final Job job in pastJobs) {
      final String month = formatter.format(job.serviceRequest.requestedDate);
      grouped.putIfAbsent(month, () => []).add(job);
    }

    return grouped;
  }

  // Parse a time string like "13:00:00" into a TimeOfDay
  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
