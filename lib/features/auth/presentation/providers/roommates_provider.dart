// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/features/auth/data/models/resident.dart';

part 'roommates_provider.g.dart';

// Change to scope of provider to application
// so nothing weird happens during routings
@Riverpod(keepAlive: true)
class Roommates extends _$Roommates {
  @override
  List<Resident> build() => [];

  void addResident(Resident resident) {
    state = [...state, resident];
  }

  void clearRoommates() {
    state = [state[0]];
  }

  void removeRoommate(Resident resident) {
    state = state.where((r) => r != resident).toList();
  }
}
