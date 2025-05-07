import 'package:mental_health_care/data/dto/haru_dto.dart';
import 'package:mental_health_care/data/model/haru.dart';

extension HaruMapper on HaruDto {
  Haru toHaru() {
    return Haru(
        id: id ?? 0,
        timeOfDay: timeOfDay ?? '',
        content: content ?? '',
        isChecked: isChecked ?? false);
  }
}
