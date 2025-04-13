// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/features/specialist/data/specialist.dart';
import 'package:zhks/features/specialist/data/specialist_repository.dart';

part 'specialist_provider.g.dart';

final specialistRepositoryProvider = Provider((ref) => SpecialistRepository());

@riverpod
Future<List<Specialist>> allSpecialists(ref) {
  final repo = ref.watch(specialistRepositoryProvider);
  return repo.getAllSpecialists();
}

@riverpod
Future<Specialist> specialistById(ref, int id) {
  final repo = ref.watch(specialistRepositoryProvider);
  return repo.getSpecialistById(id);
}

@riverpod
Future<List<Schedule>> specialistSchedules(ref, int specialistId) {
  final repo = ref.watch(specialistRepositoryProvider);
  return repo.getSchedules(specialistId);
}
