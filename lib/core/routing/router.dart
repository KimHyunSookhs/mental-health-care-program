import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/core/di/di_setup.dart';
import 'package:mental_health_care/data/data_source/haru_data_source.dart';
import 'package:mental_health_care/data/repository/haru_repository_impl.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';
import 'package:mental_health_care/presentation/haru/haru_screen.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';

import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

HaruViewModel haruViewModel = HaruViewModel(haruRepository: getIt());

final router = GoRouter(initialLocation: Routes.haruScreen, routes: [
  GoRoute(
      path: Routes.haruScreen,
      builder: (context, state) => HaruScreen(viewModel: haruViewModel))
]);
