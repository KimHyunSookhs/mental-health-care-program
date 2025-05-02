// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'you_tube.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YouTube _$YouTubeFromJson(Map<String, dynamic> json) => YouTube(
      youTubeId: json['youTubeId'] as String,
      duration: (json['duration'] as num).toInt(),
      title: json['title'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$YouTubeToJson(YouTube instance) => <String, dynamic>{
      'youTubeId': instance.youTubeId,
      'duration': instance.duration,
      'title': instance.title,
      'category': instance.category,
    };
