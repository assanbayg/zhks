// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: context.colors.primary.blue,
        unselectedItemColor: context.colors.secondary.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _getCurrentIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed('home');
              break;
            case 1:
              context.goNamed('chats');
              break;
            case 2:
              context.goNamed('account');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/chats')) return 1;
    if (location.startsWith('/account')) return 2;
    return 0;
  }
}
