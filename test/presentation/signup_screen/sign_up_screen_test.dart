import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_screen.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_view_model.dart';
import 'package:mocktail/mocktail.dart';

// SignUpViewModel Mock 클래스 (UI 렌더링 테스트에는 큰 영향 없음)
class MockSignUpViewModel extends Mock implements SignUpViewModel {
  @override
  Future<void> signUp(String email, String password, String nickname) async {}
}

void main() {
  late MockSignUpViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockSignUpViewModel();
  });

  Widget createSignupScreenForTest({MockSignUpViewModel? viewModel}) {
    return MaterialApp(
      home: SignupScreen(viewModel: viewModel ?? mockViewModel),
    );
  }

  group('SignupScreen Widget Smoke Test', () {
    testWidgets('화면에 주요 UI 요소들이 존재하는지 확인', (tester) async {
      await tester.pumpWidget(createSignupScreenForTest());

      expect(find.text('Calmi'), findsOneWidget);
      expect(find.text('마음 건강을 위한 따듯한 공간'), findsOneWidget);

      expect(find.text('이메일'), findsOneWidget);
      expect(find.byType(TextFormField).at(0), findsOneWidget); // 이메일 텍스트 필드

      expect(find.text('닉네임'), findsOneWidget);
      expect(find.byType(TextFormField).at(1), findsOneWidget); // 닉네임 텍스트 필드

      expect(find.text('비밀번호'), findsOneWidget);
      expect(find.byType(TextFormField).at(2), findsOneWidget); // 비밀번호 텍스트 필드

      expect(find.text('비밀번호 확인'), findsOneWidget);
      expect(
          find.byType(TextFormField).at(3), findsOneWidget); // 비밀번호 확인 텍스트 필드

      expect(find.widgetWithText(ElevatedButton, '회원가입'), findsOneWidget);

      expect(find.text('이미 계정이 있으신가요?'), findsOneWidget);
      expect(find.widgetWithText(TextButton, '로그인'), findsOneWidget);
    });

    testWidgets('각 텍스트 필드에 텍스트를 입력할 수 있는지 확인', (tester) async {
      await tester.pumpWidget(createSignupScreenForTest());

      await tester.enterText(
          find.byType(TextFormField).at(0), 'test@example.com');
      expect(find.text('test@example.com'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).at(1), 'test닉네임');
      expect(find.text('test닉네임'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).at(2), 'password123');
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('회원가입 버튼이 탭 가능한 상태인지 확인', (tester) async {
      await tester.pumpWidget(createSignupScreenForTest());
      expect(find.widgetWithText(ElevatedButton, '회원가입'), findsOneWidget);
    });

    testWidgets('로그인 TextButton이 탭 가능한 상태인지 확인', (tester) async {
      await tester.pumpWidget(createSignupScreenForTest());
      expect(find.widgetWithText(TextButton, '로그인'), findsOneWidget);
    });
  });
}
