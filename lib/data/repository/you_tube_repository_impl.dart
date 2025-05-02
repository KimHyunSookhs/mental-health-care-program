import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/data_source/you_tube_data_source.dart';
import 'package:mental_health_care/data/model/you_tube.dart';
import 'package:mental_health_care/domain/repository/you_tube_repository.dart';

class YouTubeRepositoryImpl implements YouTubeRepository {
  final YouTubeDataSource _dataSource;

  YouTubeRepositoryImpl({required YouTubeDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Result<List<YouTube>>> getYouTube() async {
    try {
      final List<YouTube> youTube = await _dataSource.getYouTube();
      return Result.success(youTube);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}