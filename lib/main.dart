import 'package:flutter/material.dart';
import 'package:mental_health_care/presentation/haruharu/haruharu_screen.dart';
import 'package:mental_health_care/presentation/haruharu/haruharu_view_model.dart';

import 'data/repository/haruharu_repository_impl.dart';
import 'domain/usecase/get_haruharu_use_case.dart';

void main() {
  runApp(const Calmi());
}

class Calmi extends StatelessWidget {
  const Calmi({super.key});

  @override
  Widget build(BuildContext context) {
    final haruRepository = HaruHaruRepositoryImpl();
    final getHaruHaruUseCase = GetHaruHaruUseCase(
      haruHaruRepository: haruRepository,
    );

    // 2. ViewModel 생성
    final haruHaruViewModel = HaruHaruViewModel(
      getHaruHaruUseCase: getHaruHaruUseCase,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HaruHaruScreen(viewModel: haruHaruViewModel),
    );
  }
}
