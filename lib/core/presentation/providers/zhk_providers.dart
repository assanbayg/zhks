// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/data/zhks_repository.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/posts/data/zhk.dart';

// TODO: use annotations later
final zhkRepositoryProvider = Provider<ZhkRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ZhkRepository(apiClient);
});

final zhkListProvider = FutureProvider<List<Zhk>>((ref) async {
  final repository = ref.watch(zhkRepositoryProvider);
  return repository.getZhkList();
});
