// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/chats/data/chat_repository.dart';
import 'package:zhks/features/chats/data/models/message.dart';
import 'package:zhks/features/chats/data/models/news_message.dart';
import 'package:zhks/features/chats/data/models/vote.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRepository chatRepository(ref) {
  final api = ref.read(apiClientProvider); // assuming you have this already
  return ChatRepository(api);
}

// 1. News Messages
@riverpod
Future<List<NewsMessage>> newsMessages(ref) {
  final repo = ref.read(chatRepositoryProvider);
  return repo.getNewsMessages();
}

// 2. Debt Chat Messages
@riverpod
Future<List<Message>> debtMessages(ref) {
  final repo = ref.read(chatRepositoryProvider);
  return repo.getDebtMessages();
}

// 3. Support Messages
@riverpod
Future<List<Message>> supportMessages(ref) {
  final repo = ref.read(chatRepositoryProvider);
  return repo.getSupportMessages();
}

// 4. Send support message (returns nothing but can be awaited)
@riverpod
class SendSupportMessage extends _$SendSupportMessage {
  @override
  FutureOr<void> build() {}

  Future<void> send(String message) async {
    final repo = ref.read(chatRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.sendSupportMessage(message));
    ref.invalidate(supportMessagesProvider);
  }
}

// 5. Votes List
@riverpod
Future<List<Vote>> votes(ref) {
  final repo = ref.read(chatRepositoryProvider);
  return repo.getVotes();
}

// 6. Submit vote
@riverpod
class SubmitVote extends _$SubmitVote {
  @override
  FutureOr<void> build() {}

  Future<void> submit(int voteId, int optionId) async {
    final repo = ref.read(chatRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.submitVote(voteId, optionId));
    ref.invalidate(votesProvider);
  }
}

@riverpod
class SelectedVotes extends _$SelectedVotes {
  @override
  Map<int, int> build() {
    return {}; // Initial empty state
  }

  // Optional: Add a method to update selections
  void selectOption(int voteId, int optionId) {
    state = {...state, voteId: optionId};
  }
}
