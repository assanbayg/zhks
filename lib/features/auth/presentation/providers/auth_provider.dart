// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/storage/token_storage.dart';
import 'package:zhks/features/auth/data/auth_repository.dart';
import 'package:zhks/features/auth/data/resident.dart';

part 'auth_provider.freezed.dart';

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
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    // Check auth state when created
    _checkAuth();
  }

  // Check if user is already authenticated
  Future<void> _checkAuth() async {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      state = state.copyWith(isAuthenticated: isAuthenticated);
    } catch (e) {
      // Error -> user is definitely not authenticated imho
      state = state.copyWith(isAuthenticated: false);
    }
  }

  // Request login code
  Future<void> requestLoginCode(String email) async {
    try {
      // Reset flags before making a request
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.requestLoginCode(email);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Verify login pin
  Future<void> verifyLoginCode(String email, String code) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.verifyLoginCode(email, code);

      // Successful auth if we reached here after verifyLoginCode
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        user: {'email': email},
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Register new user
  Future<void> register(Resident resident) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.register(resident);

      // After registration, user needs to login
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Add roommate
  Future<void> addRoommate(Resident resident) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.addRoommate(resident);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _authRepository.logout();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthRepository(apiClient, tokenStorage);
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return ApiClient(tokenStorage);
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});
