// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/models/service.dart';
import 'package:zhks/core/providers/service_providers.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class ServiceSelectionPage extends ConsumerWidget {
  final Function(String) onServiceSelected;

  const ServiceSelectionPage({super.key, required this.onServiceSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProvider);

    return servicesAsync.when(
      data: (services) => _buildServiceList(context, ref, services),
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, stack) =>
              Center(child: Text('Ошибка загрузки услуг: $error')),
    );
  }

  Widget _buildServiceList(
    BuildContext context,
    WidgetRef ref,
    List<Service> services,
  ) {
    final serviceFormNotifier = ref.read(serviceRequestFormProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: services.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final service = services[index];
              return ServiceCard(
                service: service,
                onTap: () {
                  serviceFormNotifier.updateServiceId(service.id);
                  onServiceSelected(service.name);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: context.colors.tertiary.gray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Icon(
                _getIconForService(service.id),
                size: 24,
                color: context.colors.primary.blue,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(service.name, style: context.texts.bodyLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForService(int serviceId) {
    switch (serviceId) {
      case 1: // Клининг
        return Icons.cleaning_services;
      case 2: // Сантехника
        return Icons.plumbing;
      case 3: // Сборка/ремонт мебели
        return Icons.chair;
      case 4: // Клейка обоев
        return Icons.wallpaper;
      case 5: // Ремонт техники
        return Icons.home_repair_service;
      case 6: // Другая услуга
        return Icons.miscellaneous_services;
      default:
        return Icons.build;
    }
  }
}
