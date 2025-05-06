import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';

class GetHaruUseCase {
  final HaruRepository haruRepository;

  GetHaruUseCase({required this.haruRepository});

  Future<Result<List<Haru>>> execute() async {
    final haruResult = await haruRepository.getHaru();

    return switch (haruResult) {
      Success(:final data) => Result.success(data),
      Error(:final e) => Result.error(e),
    };
  }
}
