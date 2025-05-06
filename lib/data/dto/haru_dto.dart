import 'package:json_annotation/json_annotation.dart';

part 'haru_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class HaruDto {
  final int? id;
  final String? timeOfDay;
  final String? content;
  final bool? isChecked;

  const HaruDto(this.id, this.timeOfDay, this.content, this.isChecked);

  factory HaruDto.fromJson(Map<String, dynamic> json) =>
      _$HaruDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HaruDtoToJson(this);
}
