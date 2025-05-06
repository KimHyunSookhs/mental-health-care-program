import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/domain/repository/you_tube_repository.dart';
import 'package:mental_health_care/domain/use_case/get_you_tube_category_use_case.dart';
import 'package:mental_health_care/presentation/meditation_screen/meditation_state.dart';

import '../../core/result/result.dart';

class MeditationViewModel with ChangeNotifier {
  final YouTubeRepository _repository;
  final GetYouTubeCategoryUseCase _useCase;

  MeditationState _state = MeditationState();

  MeditationViewModel(
      {required YouTubeRepository repository,
      required GetYouTubeCategoryUseCase useCase})
      : _repository = repository,
        _useCase = useCase;

  MeditationState get state => _state;

  Future<void> getYouTube() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final result = await _repository.getYouTube();
      switch (result) {
        case Success(data: final youtube):
          _state = state.copyWith(
              isLoading: false,
              youtube: Result.success(youtube),
              errorMessage: '');
          break;
        case Error(e: final e):
          _state = state.copyWith(
              isLoading: false,
              youtube: Result.error(e),
              errorMessage: e.toString());
          break;
      }
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }

  Future<void> getYouTubeCategory(String category) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final result = await _useCase.execute(category);
      switch (result) {
        case Success(data: final youtube):
          _state = state.copyWith(
              isLoading: false,
              youtube: Result.success(youtube),
              category: category,
              errorMessage: '');
          break;
        case Error(e: final e):
          _state = state.copyWith(
              isLoading: false,
              youtube: Result.error(e),
              errorMessage: e.toString());
          break;
      }
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }
}
