import 'package:mental_health_care/data/model/you_tube.dart';
import 'package:mental_health_care/domain/repository/you_tube_repository.dart';

import '../../core/result/result.dart';

class GetYouTubeCategoryUseCase {
  final YouTubeRepository repository;

  GetYouTubeCategoryUseCase({required this.repository});

  Future<Result<List<YouTube>>> execute(String category) async {
    final youTubeResult = await repository.getYouTubeCategory(category);

    return switch (youTubeResult) {
      Success(:final data) => Result.success(data),
      Error(:final e) => Result.error(e),
    };
  }
}
