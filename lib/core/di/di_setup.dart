import 'package:get_it/get_it.dart';
import 'package:mental_health_care/data/data_source/haru_data_source.dart';
import 'package:mental_health_care/data/data_source/haru_data_source_impl.dart';
import 'package:mental_health_care/data/repository/auth_repository_impl.dart';
import 'package:mental_health_care/data/repository/haru_repository_impl.dart';
import 'package:mental_health_care/data/repository/talk_doc_repository_impl.dart';
import 'package:mental_health_care/domain/repository/auth_repository.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';
import 'package:mental_health_care/domain/use_case/get_haru_use_case.dart';
import 'package:mental_health_care/domain/use_case/random_pick_use_case.dart';
import 'package:mental_health_care/domain/use_case/sign_in_use_case.dart';
import 'package:mental_health_care/domain/use_case/signup_use_case.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';
import 'package:mental_health_care/presentation/sign_in_screen/sign_in_view_model.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_view_model.dart';

final getIt = GetIt.instance;

void diSetUp() {
  //DataSource
  getIt.registerSingleton<HaruDataSource>(HaruDataSourceImpl());

  //Repository
  getIt.registerSingleton<HaruRepository>(
      HaruRepositoryImpl(haruDataSource: getIt()));
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<TalkDocRepository>(TalkDocRepositoryImpl());
  //UseCase
  getIt.registerSingleton(GetHaruUseCase(haruRepository: getIt()));
  getIt.registerSingleton(RandomPickUseCase(haruRepository: getIt()));
  getIt.registerSingleton(SignupUseCase(authRepository: getIt()));
  getIt.registerSingleton(SignInUseCase(authRepository: getIt()));

  //ViewModel
  getIt.registerFactory<HaruViewModel>(
      () => HaruViewModel(randomPickUseCase: getIt()));
  getIt.registerFactory<SignUpViewModel>(
      () => SignUpViewModel(signupUseCase: getIt()));
  getIt.registerFactory<SignInViewModel>(
      () => SignInViewModel(useCase: getIt()));
}
