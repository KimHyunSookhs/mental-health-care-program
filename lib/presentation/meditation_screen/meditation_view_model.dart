import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/domain/repository/you_tube_repository.dart';
import 'package:mental_health_care/presentation/meditation_screen/meditation_state.dart';

import '../../core/result/result.dart';

class MeditationViewModel with ChangeNotifier {
  final YouTubeRepository _repository;

  MeditationViewModel({required YouTubeRepository repository}) : _repository = repository;

  MeditationState _state = MeditationState();

  MeditationState get state => _state;

  Future<void> getYouTube() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final result = await _repository.getYouTube();
      switch (result) {
        case Success(data: final youtube):
          _state = state.copyWith(
              isLoading: false, youtube: Result.success(youtube), errorMessage: '');
          break;
        case Error(e: final e):
          print('에러 발생: $e');
          _state = state.copyWith(
              isLoading: false,
              youtube: Result.error(e),
              errorMessage: e.toString());
          break;
      }
    } catch (e) {
      print('예외 발생: $e');
      throw Exception(e);
    }
    notifyListeners();
  }


}
