// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/onboarding/presentation/onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Управляйте домом с помощью смартфона',
      'description':
          'Отправляйте заявки, заполняйте пропуска, принимайте участие в общих собраниях, будьте в курсе новостей',
    },
    {
      'title': 'Оптимизируйте свои повседневные дела',
      'description':
          'Автоматизируйте задачи, оптимизируйте расписания, устанавливайте напоминания и упростите себе жизнь с помощью интеллектуальных технологий.',
    },
    {
      'title': 'Улучшите домашнюю безопасность без особых усилий',
      'description':
          'Следите за своим имуществом, получайте оповещения и защищайте свой дом с помощью передовых систем наблюдения и интеллектуальных замков.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/onboarding_bg.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 250,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(pages.length, (index) {
                      final isCurrentPage = index == _currentPage;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isCurrentPage ? 30 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape:
                              isCurrentPage
                                  ? BoxShape.rectangle
                                  : BoxShape.circle,
                          borderRadius:
                              isCurrentPage ? BorderRadius.circular(5) : null,
                          color:
                              isCurrentPage
                                  ? context.colors.primary.blue
                                  : context.colors.primary.gray,
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: pages.length,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            children: [
                              Text(
                                pages[index]['title']!,
                                style: context.texts.titleMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pages[index]['description']!,
                                style: context.texts.bodyMedium.copyWith(
                                  color: context.colors.primary.gray,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Wrap with consumer to not be navigated to onboarding each time
              child: Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      await ref.read(onboardingCompleteProvider.future);
                      // Immediately reflect changes
                      ref.invalidate(onboardingStateProvider);
                      // ignore: use_build_context_synchronously
                      context.go('/login');
                    },
                    style: context.buttons.primaryButtonStyle,
                    child: Text(
                      'Начать',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
