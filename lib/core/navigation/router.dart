// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/providers/auth_provider.dart';
import 'package:zhks/core/providers/onboarding_provider.dart';
import 'package:zhks/features/auth/presentation/add_roommate_screen.dart';
import 'package:zhks/features/auth/presentation/login_screen.dart';
import 'package:zhks/features/auth/presentation/onboarding_screen.dart';
import 'package:zhks/features/auth/presentation/register_screen.dart';
import 'package:zhks/features/auth/presentation/select_lang_screen.dart';
import 'package:zhks/features/auth/presentation/thanks_screen.dart';
import 'package:zhks/features/home_screen.dart';
import 'package:zhks/features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  // Ensure the router waits until state is loaded from SharedPreferences
  // While hasSeenOnboarding just stores if user saw it or not
  final hasSeenOnboardingAsync = ref.watch(onboardingStateProvider);

  return GoRouter(
    // change back
    initialLocation: '/thanks',

    // initialLocation: '/register',
    redirect: (context, state) {
      // Don't redirect anywhere if something is loading
      if (hasSeenOnboardingAsync.isLoading || authState.isLoading) {
        return null;
      }

      final hasSeenOnboarding = hasSeenOnboardingAsync.value ?? false;
      // final isLoggedIn = authState.isAuthenticated;
      final isLoggedIn = true; // temp
      final isAuthRoute =
          state.uri.path == '/login' || state.uri.path == '/register';

      // Allow manual navigation to /onboarding
      if (state.uri.path == '/onboarding') {
        return null;
      }

      if (!hasSeenOnboarding) return '/select-lang';
      // if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/settings';

      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder:
            (_, __) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
      ),
      GoRoute(
        path: '/select-lang',
        builder: (context, state) => SelectLangScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/thanks', builder: (context, state) => ThanksScreen()),
      GoRoute(
        path: '/add-roommate',
        builder: (context, state) => AddRoommateScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
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
