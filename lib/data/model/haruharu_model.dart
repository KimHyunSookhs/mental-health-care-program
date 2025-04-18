import 'package:freezed_annotation/freezed_annotation.dart';

import 'category/haruharu_enum.dart';

part 'haruharu_model.freezed.dart';

@freezed
abstract class HaruHaruModel with _$HaruHaruModel {
  const factory HaruHaruModel({
    required HaruHaruEnum category,
    required String content,
  }) = _HaruHaruModel;
}
