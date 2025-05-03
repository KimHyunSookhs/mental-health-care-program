import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mental_health_care/data/model/you_tube.dart';

import '../../core/result/result.dart';

part 'meditation_state.freezed.dart';

@freezed
abstract class MeditationState with _$MeditationState {
  const factory MeditationState({
    @Default(Result<List<YouTube>>.success([])) Result<List<YouTube>> youtube,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default('All') String category,
  }) = _MeditationState;
}
