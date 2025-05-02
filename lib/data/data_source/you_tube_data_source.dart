import 'package:mental_health_care/data/model/you_tube.dart';

abstract interface class YouTubeDataSource {
  Future<List<YouTube>> getYouTube();
}
