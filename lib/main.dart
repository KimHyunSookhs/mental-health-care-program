import 'package:flutter/material.dart';
import 'package:mental_health_care/data/data_source/haru_data_source_impl.dart';
import 'package:mental_health_care/data/repository/haru_repository_impl.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';

import 'core/routing/router.dart';

void main() {
  runApp(Calmi());
}

class Calmi extends StatelessWidget {
  const Calmi({super.key});

  @override
  Widget build(BuildContext context) {
    final haruViewModel = HaruViewModel(
        haruRepository:
            HaruRepositoryImpl(haruDataSource: HaruDataSourceImpl()));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
