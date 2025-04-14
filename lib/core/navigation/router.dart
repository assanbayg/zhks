// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/navigation/main_shell.dart';
import 'package:zhks/core/presentation/screens/home_screen.dart';
import 'package:zhks/core/presentation/screens/settings_screen.dart';
import 'package:zhks/core/presentation/screens/test_screen.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/auth/presentation/screens/add_roommate_screen.dart';
import 'package:zhks/features/auth/presentation/screens/login_screen.dart';
import 'package:zhks/features/auth/presentation/screens/register_screen.dart';
import 'package:zhks/features/auth/presentation/screens/thanks_screen.dart';
import 'package:zhks/features/job/presentation/jobs_screen.dart';
import 'package:zhks/features/onboarding/presentation/onboarding_provider.dart';
import 'package:zhks/features/onboarding/presentation/onboarding_screen.dart';
import 'package:zhks/features/onboarding/presentation/select_lang_screen.dart';
import 'package:zhks/features/posts/presentation/posts_screen.dart';
import 'package:zhks/features/reports/presentation/reports_screen.dart';
import 'package:zhks/features/request/presentation/request_screen.dart';
import 'package:zhks/features/specialist/presentation/specialists_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  // Ensure the router waits until state is loaded from SharedPreferences
  // While hasSeenOnboarding just stores if user saw it or not
  final onboardingAsync = ref.watch(onboardingStateProvider);

  return GoRouter(
    // initialLocation: '/select-lang',
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Don't redirect anywhere if something is loading
      if (onboardingAsync.isLoading || authState.isLoading) return null;

      final hasSeenOnboarding = onboardingAsync.value ?? false;
      // final isLoggedIn = authState.isAuthenticated;
      final isLoggedIn = true; // TEMP

      final isAuthRoute = [
        '/login',
        '/register',
        '/thanks',
        '/add-roommate',
      ].contains(state.uri.path);

      // Allow manual navigation to /onboarding
      if (state.uri.path == '/onboarding') {
        return null;
      }

      if (!hasSeenOnboarding) return '/select-lang';
      // if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/';

      return null;
    },
    routes: [
      GoRoute(path: '/test', name: 'test', builder: (_, __) => TestScreen()),
      GoRoute(
        path: '/loading',
        builder:
            (_, __) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
      ),
      GoRoute(
        path: '/select-lang',
        name: 'selectLang',
        builder: (_, __) => SelectLangScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (_, __) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/thanks',
        name: 'thanks',
        builder: (_, __) => ThanksScreen(),
      ),
      GoRoute(
        path: '/add-roommate',
        name: 'addRoommate',
        builder: (_, __) => AddRoommateScreen(),
      ),

      /// Main shell with Bottom Navigation Bar
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(path: '/', name: 'home', builder: (_, __) => HomeScreen()),
          GoRoute(
            path: '/home/request',
            name: 'requestService',
            builder: (_, __) => RequestScreen(),
          ),
          GoRoute(
            path: '/home/reports',
            name: 'reports',
            builder: (_, __) => ReportsScreen(),
          ),
          GoRoute(
            path: '/home/posts',
            name: 'posts',
            builder: (_, __) => PostsScreen(),
          ),
          GoRoute(
            path: '/home/specialists',
            name: 'specialists',
            builder: (_, __) => SpecialistsScreen(),
          ),

          // GoRoute(path: '/chats', name: 'chats', builder: (_, __) => ChatsScreen()),
          GoRoute(
            path: '/account',
            name: 'account',
            builder: (_, __) => SettingsScreen(),
          ),
          GoRoute(
            path: '/jobs',
            name: 'jobs',
            builder: (_, __) => JobsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
