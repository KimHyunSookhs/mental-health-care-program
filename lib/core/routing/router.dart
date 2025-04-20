import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/core/di/di_setup.dart';
import 'package:mental_health_care/presentation/bottom_navigation_bar/bottom_navigation_bar_scaffold.dart';
import 'package:mental_health_care/presentation/haru/haru_screen.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';
import 'package:mental_health_care/presentation/secret_store/secret_stroe_screen.dart';
import 'package:mental_health_care/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_screen.dart';
import 'package:mental_health_care/presentation/splashscreen/splash_screen.dart';

import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

HaruViewModel haruViewModel = HaruViewModel(randomPickUseCase: getIt());

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splashScreen,
    routes: [
      GoRoute(
          path: Routes.splashScreen,
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: Routes.signUpScreen,
          builder: (context, state) => SignupScreen(viewModel: getIt())),
      GoRoute(
          path: Routes.signInScreen,
          builder: (context, state) => SignInScreen()),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BottomNavigationBarScaffold(
              child: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                  path: Routes.haruScreen,
                  builder: (context, state) => HaruScreen(viewModel: getIt())),
              GoRoute(
                  path: Routes.secretStoreScreen,
                  builder: (context, state) => SecretStroeScreen()),
              GoRoute(
                  path: Routes.splashScreen,
                  builder: (context, state) => SplashScreen()),
            ])
          ]),
    ]);
