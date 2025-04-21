// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/specialist/presentation/specialist_provider.dart';
import 'package:zhks/features/specialist/presentation/specialist_schedule.dart';

class SpecialistsScreen extends ConsumerWidget {
  const SpecialistsScreen({super.key});

  // Phone formatter: +7 (707) 123 45 67
  String formatPhone(String phone) {
    if (phone.length != 11 || !phone.startsWith('7')) return phone;
    return '+7 (${phone.substring(1, 4)}) ${phone.substring(4, 7)} '
        '${phone.substring(7, 9)} ${phone.substring(9)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primary = context.colors.primary;
    final teritary = context.colors.tertiary;

    final Map<String, Color> positionColorMap = {
      'Техник': primary.green,
      'Сантехник': primary.blue,
      'Уборщик': primary.orange,
      'Слесарь': primary.red,
      // ... i tak dalee
    };
    final asyncSpecialists = ref.watch(allSpecialistsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Специалисты',
        showBackButton: true,
        location: '/',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: asyncSpecialists.when(
          data: (specialists) {
            if (specialists.isEmpty) {
              return const Center(child: Text('Нет доступных специалистов'));
            }

            return ListView.builder(
              itemCount: specialists.length,
              itemBuilder: (context, index) {
                final s = specialists[index];
                final badgeColor = positionColorMap[s.position] ?? primary.gray;

                final today = DateTime.now().weekday;
                final isOnShift =
                    s.schedules?.any((sched) {
                      final dayIndex =
                          SpecialistSchedule.weekdayMap.entries
                              .firstWhere(
                                (e) => e.value == sched.day,
                                orElse: () => const MapEntry(0, ''),
                              )
                              .key;
                      return dayIndex == today;
                    }) ??
                    false;

                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: teritary.gray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(),
                          const SizedBox(width: 12),
                          Text(s.name, style: context.texts.bodyLargeSemibold),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatPhone(s.phone),
                            style: context.texts.bodyLarge.copyWith(
                              color: primary.gray,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              s.position,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              if (context.mounted) {
                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder:
                                      (_) => SpecialistSchedule(
                                        schedule: s.schedules!,
                                      ),
                                );
                              }
                            },
                            label: Text(
                              'Открыть расписание',
                              style: TextStyle(color: primary.black),
                            ),
                            icon: Icon(Icons.access_time, color: primary.gray),
                          ),
                          isOnShift
                              ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primary.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'На смене',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                              : Text(
                                'Выходной',
                                style: TextStyle(color: primary.gray),
                              ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => const Center(child: Text('Ошибка загрузки')),
        ),
      ),
    );
  }
}
