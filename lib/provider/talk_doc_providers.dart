import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_health_care/data/repository/talk_doc_repository_impl.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';
import 'package:mental_health_care/presentation/talk_doc/talk_doc_screen_notifier.dart';
import 'package:mental_health_care/presentation/talk_doc/talk_doc_screen_state.dart';

final talkDocRepositoryProvider = Provider<TalkDocRepository>(
  (ref) => TalkDocRepositoryImpl(),
);

final talkDocScreenProvider =
    StateNotifierProvider<TalkDocScreenNotifier, TalkDocScreenState>(
  (ref) =>
      TalkDocScreenNotifier(repository: ref.watch(talkDocRepositoryProvider)),
);
