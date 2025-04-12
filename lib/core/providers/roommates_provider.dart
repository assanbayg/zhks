// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/core/models/resident.dart';

part 'roommates_provider.g.dart';

// Change to scope of provider to application
// so nothing weird happens during routings
@Riverpod(keepAlive: true)
class Roommates extends _$Roommates {
  @override
  List<Resident> build() => [];

  void addRoommate(Resident resident) {
    state = [...state, resident];
  }

  void clearRoommates() {
    state = [state[0]];
  }
}
