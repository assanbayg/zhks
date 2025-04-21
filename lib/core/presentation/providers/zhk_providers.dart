// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/core/data/models/zhk.dart';
import 'package:zhks/core/data/zhks_repository.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';

part 'zhk_providers.g.dart';

@riverpod
ZhkRepository zhkRepository(ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ZhkRepository(apiClient);
}

@riverpod
Future<List<Zhk>> zhkList(ref) {
  final repository = ref.watch(zhkRepositoryProvider);
  return repository.getZhkList();
}
