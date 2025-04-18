import 'package:freezed_annotation/freezed_annotation.dart';

import 'category/routine_category.dart';

part 'haruharu_model.freezed.dart';
part 'haruharu_model.g.dart';

@freezed
abstract class HaruHaruModel with _$HaruHaruModel {
  const factory HaruHaruModel({
    required RoutineCategory category,
    required String content,
    required bool check,
  }) = _HaruHaruModel;

  factory HaruHaruModel.fromJson(Map<String, dynamic> json) =>
      _$HaruHaruModelFromJson(json);
}
