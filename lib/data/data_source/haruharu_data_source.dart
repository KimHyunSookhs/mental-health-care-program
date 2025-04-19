import 'package:mental_health_care/data/model/haru_haru_model.dart';

abstract interface class HaruHaruDataSource {
  Future<List<HaruHaruModel>> getHaruList();
}
