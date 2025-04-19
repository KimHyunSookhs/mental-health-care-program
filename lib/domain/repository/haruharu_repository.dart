import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru_haru_model.dart';

abstract interface class HaruHaruRepository {
  Future<Result<List<HaruHaruModel>>> getHaruList();
}
