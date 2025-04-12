// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/providers/specialist_provider.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/specialists/specialist_schedule.dart';

class SpecialistsScreen extends ConsumerWidget {
  const SpecialistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primary = context.colors.primary;
    final teritary = context.colors.tertiary;

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
          data:
              (specialists) => ListView.builder(
                itemCount: specialists.length,
                itemBuilder: (context, index) {
                  final s = specialists[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: teritary.gray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            CircleAvatar(),
                            Text(
                              s.name,
                              style: context.texts.bodyLargeSemibold,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // TODO: put into the mask
                                Text(
                                  s.phone,
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
                                    // TODO: make a map with position and color as keys
                                    color: primary.blue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    s.position,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
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
                                  icon: Icon(
                                    Icons.access_time,
                                    color: primary.gray,
                                  ),
                                ),
                                // TODO: compare with current date and change status
                                true
                                    ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primary.black,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
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
                      ],
                    ),
                  );
                },
              ),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Ошибка загрузки')),
        ),
      ),
    );
  }
}
