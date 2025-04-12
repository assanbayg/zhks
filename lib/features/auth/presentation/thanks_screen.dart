// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Спасибо', showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_work_rounded, size: 100, color: Colors.amber),
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
            const SizedBox(height: 48),
            ElevatedButton(
              style: context.buttons.primaryButtonStyle,
              onPressed: () {
                context.go('/home');
              },
              child: const Text('Начать'),
            ),
            const SizedBox(height: 16),
            _buildAddRoommateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddRoommateButton(BuildContext context) {
    // TODO: show the number of roommate to be added (after adding riverpod provider)
    return InkWell(
      onTap: () => context.go('/add-roommate'),
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
          ],
        ),
      ),
    );
  }
}
