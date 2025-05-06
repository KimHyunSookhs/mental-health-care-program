import 'package:freezed_annotation/freezed_annotation.dart';

part 'you_tube.freezed.dart';
part 'you_tube.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class YouTube with _$YouTube {
  final String youTubeId;
  final int duration;
  final String title;
  final String category;

  const YouTube({
    required this.youTubeId,
    required this.duration,
    required this.title,
    required this.category,
  });

  factory YouTube.fromJson(Map<String, dynamic> json) =>
      _$YouTubeFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeToJson(this);
}
