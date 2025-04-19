import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/data_source/haru_data_source.dart';
import 'package:mental_health_care/data/dto/haru_dto.dart';
import 'package:mental_health_care/data/mapper/haru_mapper.dart';
import 'package:mental_health_care/data/model/haru.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';

class HaruRepositoryImpl implements HaruRepository {
  final HaruDataSource haruDataSource;

  HaruRepositoryImpl({required this.haruDataSource});

  @override
  Future<Result<List<Haru>>> getHaru() async {
    try {
      final List<HaruDto> dto = await haruDataSource.getHaruList();
      final List<Haru> models = dto.map((e) => e.toHaru()).toList();
      return Result.success(models);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
