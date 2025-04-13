// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/job/data/job.dart';

class JobWidget extends StatelessWidget {
  final Job job;
  const JobWidget({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.tertiary.gray;
    final primary = context.colors.primary;

    // Format date and time for display
    String formatDate(String dateStr) {
      final date = DateTime.parse(dateStr);
      final dateFormatter = DateFormat('dd.MM.yy', 'ru_RU');
      return dateFormatter.format(date);
    }

    // Format specialist's name
    String formatName(String fullName) {
      List<String> temp = fullName.split(' ');
      String last = temp.last;
      String firstInitial = temp.first[0];
      String thirdInitial = temp.length > 2 ? temp[2][0] : "";
      return "$last $firstInitial. ${thirdInitial.isNotEmpty ? '$thirdInitial.' : ''}";
    }

    // Get icon by service ID
    IconData getServiceIcon(int serviceId) {
      switch (serviceId) {
        case 1:
          return Icons.cleaning_services; // Клининг
        case 2:
          return Icons.plumbing; // Сантехника
        case 3:
          return Icons.chair; // Сборка/ремонт мебели
        case 4:
          return Icons.wallpaper; // Клейка обоев
        case 5:
          return Icons.handyman; // Ремонт техники
        default:
          return Icons.miscellaneous_services; // Другая услуга
      }
    }

    // Get color based on specialist's position
    Color getPositionColor(String position, dynamic primary) {
      switch (position) {
        case 'Техник':
          return primary.green;
        case 'Сантехник':
          return primary.blue;
        case 'Уборщик':
          return primary.orange;
        case 'Слесарь':
          return primary.red;
        default:
          return primary.gray;
      }
    }

    final serviceRequest = job.serviceRequest;
    final specialist = job.specialist;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            Icon(
              getServiceIcon(serviceRequest.serviceId),
              color: context.colors.primary.blue,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceRequest.service?.name ?? 'Услуга',
                          style: context.texts.bodyLarge,
                        ),
                        Text(
                          formatDate(
                            serviceRequest.requestedDate.toIso8601String(),
                          ),
                          style: context.texts.bodyMedium.copyWith(
                            color: primary.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Работник: ',
                              style: TextStyle(color: primary.gray),
                            ),
                            Text(
                              formatName(specialist.name),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getPositionColor(
                              specialist.position,
                              primary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            specialist.position,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
