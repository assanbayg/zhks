// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Главная'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 24,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/main_1.png',
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 180,
              ),
            ),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _HomeCard(
                    icon: Icons.edit_document,
                    label: 'Подать заявку',
                    onTap: () => context.goNamed('requestService'),
                  ),
                  _HomeCard(
                    icon: Icons.insert_drive_file_outlined,
                    label: 'Отчеты',
                    onTap: () => context.goNamed('reports'),
                  ),
                  _HomeCard(
                    icon: Icons.apartment_rounded,
                    label: 'ЖК',
                    onTap: () => context.goNamed('complex'),
                  ),
                  _HomeCard(
                    icon: Icons.build_rounded,
                    label: 'Специалисты',
                    onTap: () => context.goNamed('specialists'),
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

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.tertiary.blue,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 68, color: context.colors.primary.blue),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: context.texts.bodyLargeSemibold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
