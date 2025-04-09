// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/providers/onboarding_provider.dart';
import 'package:zhks/core/themes/button_theme_extension.dart';
import 'package:zhks/core/themes/color_palette_extension.dart';

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
      body: Column(
        children: [
          Image.asset(
            'lib/assets/onboarding_bg.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: 225,
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
                                ? Theme.of(context).primaryColor
                                : Theme.of(
                                  context,
                                ).extension<ColorPaletteExtension>()?.textGray,
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
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            Text(
                              pages[index]['title']!,
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Text(
                                  pages[index]['description']!,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context)
                                            .extension<ColorPaletteExtension>()
                                            ?.textGray,
                                    fontSize: 15,
                                  ),
                                ),
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

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () async {
                    ref.read(onboardingCompleteProvider);
                    // ignore: use_build_context_synchronously
                    context.go('/login');
                  },
                  style:
                      Theme.of(
                        context,
                      ).extension<ButtonThemeExtension>()?.primaryButtonStyle,
                  child: Text(
                    'Начать',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
