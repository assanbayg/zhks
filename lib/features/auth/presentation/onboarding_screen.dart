// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

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
              // TODO: test on bottom overflows
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
                            isCurrentPage
                                ? BorderRadius.circular(5)
                                : null, // Round the wide one
                        color:
                            isCurrentPage
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
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
                            Text(pages[index]['description']!),
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
            child: ElevatedButton(
              onPressed: () => context.go('/login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), //
                ),
              ),
              child: Text(
                'Начать',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
