// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/data/models/user_profile.dart';
import 'package:zhks/features/auth/data/repositories/profile_repository.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';

class ProfileState {
  final UserProfile? profile;
  final bool isLoading;
  final String? error;

  const ProfileState({this.profile, this.isLoading = false, this.error});

  ProfileState copyWith({
    UserProfile? profile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileNotifier(this._profileRepository) : super(const ProfileState());

  // Add new parameter to force caching refresh
  Future<void> fetchUserProfile({bool forceRefresh = false}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final profile = await _profileRepository.getUserProfile(
        forceRefresh: forceRefresh,
      );
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileRepository(apiClient);
});

final profileStateProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
      final profileRepository = ref.watch(profileRepositoryProvider);
      return ProfileNotifier(profileRepository);
    });
