import 'package:mental_health_care/data/model/haruharu_model.dart';

abstract interface class HaruHaruDataSource {
  Future<List<HaruHaruModel>> getHaruList();
}
