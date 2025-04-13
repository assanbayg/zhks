// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_provider.freezed.dart';

// аннотации оказывается капец прикольная тема
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    String? error,
    Map<String, dynamic>? user,
  }) = _AuthState;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  // Mock login with email (no backend yet, why did I configure dio though)
  Future<void> login(String email) async {
    try {
      // Show loading state
      state = state.copyWith(isLoading: true, error: null);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (email.isNotEmpty) {
        // Successful login
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          user: {'email': email, 'name': 'Test User', 'id': '12345'},
        );
      } else {
        // failed login
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid email or password',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Receive code
  Future<void> requestLoginCode(String email) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // just pretend we sent a code
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> verifyLoginCode(String email, String code) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await Future.delayed(const Duration(seconds: 1));

      if (code == '1234' || code.length >= 4) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          user: {'email': email, 'name': 'Test User', 'id': '12345'},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid verification code',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // For MVP, just accept any valid data
      if (userData['email'] != null) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          user: {...userData, 'id': '12345'},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Please fill all required fields',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void logout() {
    state = const AuthState();
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
