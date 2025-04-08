// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/providers/auth_provider.dart';
import 'package:zhks/features/auth/presentation/login_screen.dart';
import 'package:zhks/features/auth/presentation/onboarding_screen.dart';
import 'package:zhks/features/auth/presentation/register_screen.dart';
import 'package:zhks/features/auth/presentation/select_lang_screen.dart';
import 'package:zhks/features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/onboarding',
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isAuthRoute =
          state.uri.toString() == '/login' ||
          state.uri.toString() == '/register';

      // Prevent redirects while loading
      if (authState.isLoading) return null;

      if (!isLoggedIn && !isAuthRoute) return '/onboarding';
      if (isLoggedIn && isAuthRoute) return '/settings';

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
