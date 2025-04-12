// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/models/specialist.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class SpecialistSchedule extends StatelessWidget {
  final List<Schedule> schedule;
  const SpecialistSchedule({super.key, required this.schedule});

  static const Map<int, String> weekdayMap = {
    1: 'Понедельник',
    2: 'Вторник',
    3: 'Среда',
    4: 'Четверг',
    5: 'Пятница',
    6: 'Суббота',
    7: 'Воскресенье',
  };

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday; // 1 = пн, 7 = вск
    final todayName = weekdayMap[todayIndex]!;

    final scheduleMap = {for (final s in schedule) s.day: s};

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('График работы', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weekdayMap.length,
            itemBuilder: (context, index) {
              final dayName = weekdayMap[index + 1]!;
              final isToday = dayName == todayName;
              final scheduleEntry = scheduleMap[dayName];

              final timeText =
                  scheduleEntry != null
                      ? '${scheduleEntry.startTime} – ${scheduleEntry.endTime}'
                      : 'Выходной';

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dayName,
                      style: TextStyle(
                        color:
                            isToday
                                ? context.colors.primary.black
                                : context.colors.primary.gray,
                      ),
                    ),
                    isToday
                        ? Text(
                          'Сегодня',
                          style: TextStyle(
                            color: context.colors.primary.blue,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                        : SizedBox(),
                    Text(timeText),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
