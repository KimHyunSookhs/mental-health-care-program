import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mental_health_care/data/model/haru.dart';

part 'haru_state.freezed.dart';

@freezed
abstract class HaruState with _$HaruState {
  const factory HaruState({
    @Default(<Haru>[]) List<Haru> haru,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _HaruState;
}
