// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_provider.g.dart';

// Locally store the onboarding state
@riverpod
Future<bool> onboardingState(ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hasSeenOnboarding') ?? false;
}

@riverpod
Future<void> onboardingComplete(ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasSeenOnboarding', true);
}

@riverpod
Future<void> onboardingIncomplete(ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasSeenOnboarding', false);
}
