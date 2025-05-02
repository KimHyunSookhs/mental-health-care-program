import 'package:mental_health_care/data/model/you_tube.dart';

import '../../core/result/result.dart';

abstract class YouTubeRepository {
  Future<Result<List<YouTube>>> getYouTube();
}
