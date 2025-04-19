import 'package:freezed_annotation/freezed_annotation.dart';

part 'haru_haru_model.freezed.dart';
part 'haru_haru_model.g.dart';

@freezed
abstract class HaruHaruModel with _$HaruHaruModel {
  const factory HaruHaruModel({
    required String timeOfDay,
    required String content,
    required bool isChecked,
  }) = _HaruHaruModel;

  factory HaruHaruModel.fromJson(Map<String, Object?> json) =>
      _$HaruHaruModelFromJson(json);
}
