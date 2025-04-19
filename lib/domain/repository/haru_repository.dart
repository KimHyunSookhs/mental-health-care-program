import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru.dart';

abstract interface class HaruRepository {
  Future<Result<List<Haru>>> getHaru();
}
