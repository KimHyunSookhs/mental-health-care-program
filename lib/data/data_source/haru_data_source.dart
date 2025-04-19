import 'package:mental_health_care/data/dto/haru_dto.dart';

abstract interface class HaruDataSource {
  Future<List<HaruDto>> getHaruList();
}
