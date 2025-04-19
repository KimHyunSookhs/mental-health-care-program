import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru_haru_model.dart';
import 'package:mental_health_care/domain/repository/haruharu_repository.dart';

class GetHaruHaruUseCase {
  final HaruHaruRepository _haruHaruRepository;

  GetHaruHaruUseCase({required HaruHaruRepository haruHaruRepository})
    : _haruHaruRepository = haruHaruRepository;

  Future<Result<List<HaruHaruModel>>> execute() async {
    final results = await _haruHaruRepository.getHaruList();
    switch (results) {
      case Success<List<HaruHaruModel>>():
        return Result.success(results.data);
      case Error<List<HaruHaruModel>>():
        return Result.error(results.e);
      default:
        return Result.error('Unexpected result type');
    }
  }
}
