import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haruharu_model.dart';

abstract interface class HaruHaruRepository {
  Future<Result<List<HaruHaruModel>>> getHaruList();
}
