// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/auth/presentation/widgets/select_lang_button.dart';

class SelectLangScreen extends StatelessWidget {
  const SelectLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // TODO: replace with another icon
          Center(
            child: Icon(
              Icons.home_work_rounded,
              size: 100,
              color: Colors.amber,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Выберите язык', style: context.texts.bodyLarge),
                  SizedBox(height: 16),
                  // TODO: actually change language
                  SelectLangButton(
                    flagPath: 'lib/assets/kz.png',
                    label: 'Қазақ тілі',
                    onTap: () {
                      context.go('/onboarding');
                    },
                  ),
                  SizedBox(height: 6),
                  SelectLangButton(
                    flagPath: 'lib/assets/ru.png',
                    label: 'Русский язык',
                    onTap: () {
                      context.go('/onboarding');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
