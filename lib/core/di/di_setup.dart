import 'package:get_it/get_it.dart';
import 'package:mental_health_care/data/data_source/haru_data_source.dart';
import 'package:mental_health_care/data/data_source/haru_data_source_impl.dart';
import 'package:mental_health_care/data/repository/haru_repository_impl.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';
import 'package:mental_health_care/domain/use_case/get_haru_use_case.dart';
import 'package:mental_health_care/domain/use_case/random_pick_use_case.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';

final getIt = GetIt.instance;

void diSetUp() {
  //DataSource
  getIt.registerSingleton<HaruDataSource>(HaruDataSourceImpl());

  //Repository
  getIt.registerSingleton<HaruRepository>(
      HaruRepositoryImpl(haruDataSource: getIt()));

  //UseCase
  getIt.registerSingleton(GetHaruUseCase(haruRepository: getIt()));
  getIt.registerSingleton(RandomPickUseCase(haruRepository: getIt()));

  //ViewModel
  getIt.registerFactory<HaruViewModel>(
      () => HaruViewModel(randomPickUseCase: getIt()));
}
