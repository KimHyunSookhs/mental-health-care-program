import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/core/di/di_setup.dart';
import 'package:mental_health_care/presentation/bottom_navigation_bar/bottom_navigation_bar_scaffold.dart';
import 'package:mental_health_care/presentation/haru/haru_screen.dart';
import 'package:mental_health_care/presentation/haru/haru_view_model.dart';
import 'package:mental_health_care/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_screen.dart';
import 'package:mental_health_care/presentation/splashscreen/splash_screen.dart';
import 'package:mental_health_care/presentation/talk_doc/talk_doc_screen.dart';

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
          builder: (context, state) => SignInScreen(
                viewModel: getIt(),
              )),
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
                path: Routes.talkDocScreen,
                builder: (context, state) {
                  // initialSystemPrompt가 해당 스코프에서 접근 가능하다고 가정합니다.
                  const initialSystemPrompt =
                      "당신은 친절하고 공감 능력이 뛰어난 심리 상담사입니다. 사용자의 감정에 깊이 공감하며, 따뜻하고 편안한 어투로 답변해주세요.";
                  return TalkDocScreen(
                    talkDocRepository: getIt(),
                    // TalkDocRepository 타입으로 getIt에서 인스턴스를 가져옵니다.
                    initialSystemPrompt: initialSystemPrompt,
                  );
                },
              ),
              GoRoute(
                  path: Routes.splashScreen,
                  builder: (context, state) => SplashScreen()),
            ])
          ]),
    ]);
