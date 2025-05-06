// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haru_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HaruDto _$HaruDtoFromJson(Map<String, dynamic> json) => HaruDto(
      (json['id'] as num?)?.toInt(),
      json['timeOfDay'] as String?,
      json['content'] as String?,
      json['isChecked'] as bool?,
    );

Map<String, dynamic> _$HaruDtoToJson(HaruDto instance) => <String, dynamic>{
      'id': instance.id,
      'timeOfDay': instance.timeOfDay,
      'content': instance.content,
      'isChecked': instance.isChecked,
    };
