// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/features/job/data/job.dart';
import 'package:zhks/features/job/data/job_repository.dart';

part 'job_providers.g.dart';

// Provider for the repository itself
@riverpod
JobRepository jobRepository(ref) {
  return JobRepository();
}

// Provider for fetching jobs
@riverpod
Future<List<Job>> jobs(ref) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getJobs();
}
