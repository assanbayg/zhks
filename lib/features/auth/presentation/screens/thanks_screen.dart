// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/auth/presentation/providers/roommates_provider.dart';

class ThanksScreen extends ConsumerWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Спасибо', showBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_work_rounded, size: 80, color: Colors.amber),
                  const SizedBox(height: 24),
                  Text(
                    'Спасибо, за выбор нашего сервиса',
                    style: context.texts.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Ваша заявка отправлена на рассмотрение',
                      style: context.texts.bodyLarge.copyWith(
                        color: Color(0xFF7A8FB7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/thanks_bg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 192),
                      ElevatedButton(
                        style: context.buttons.primaryButtonStyle,
                        onPressed: () => context.go('/home'),
                        child: Text('Начать'),
                      ),
                      SizedBox(height: 16),
                      _buildAddRoommateButton(context, ref),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddRoommateButton(BuildContext context, WidgetRef ref) {
    final residents = ref.watch(roommatesProvider);

    return InkWell(
      onTap: () => context.go('/add-resident'),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: context.colors.primary.blue, width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                'Добавить сожителя',
                textAlign: TextAlign.center,
                style: context.texts.titleSmall.copyWith(
                  color: context.colors.primary.blue,
                ),
              ),
            ),
            Positioned(
              right: 16,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: context.colors.primary.blue,
              ),
            ),
            Positioned(
              left: 16,
              child: Container(
                alignment: Alignment.center,
                width: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.primary.blue,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${residents.length + 1}',
                  style: context.texts.titleSmall.copyWith(
                    color: context.colors.primary.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
