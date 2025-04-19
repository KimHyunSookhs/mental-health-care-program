import 'package:freezed_annotation/freezed_annotation.dart';

part 'haru.freezed.dart';

@freezed
class Haru with _$Haru {
  final String timeOfDay;
  final String content;
  final bool isChecked;

  const Haru(
      {required this.timeOfDay,
      required this.content,
      required this.isChecked});
}
