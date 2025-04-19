import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/model/haru_haru_model.dart';

part 'haruharu_state.freezed.dart';

@freezed
abstract class HaruHaruState with _$HaruHaruState {
  const factory HaruHaruState({
    @Default(<HaruHaruModel>[]) List<HaruHaruModel> haruModel,
    @Default(false) bool isHaruLoading,
  }) = _HaruHaruState;
}
