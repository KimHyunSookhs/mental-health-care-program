import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mental_health_care/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:mental_health_care/presentation/sign_in_screen/sign_in_view_model.dart';
import 'package:mocktail/mocktail.dart';

// SignInViewModel Mock 클래스 생성 (화면 출력 테스트에는 큰 영향 없음)
class MockSignInViewModel extends Mock implements SignInViewModel {
  @override
  String? get email => '';

  @override
  String? get password => '';

  @override
  Future<void> loadStoredCredentials() async {}

  @override
  Future<void> signIn(String email, String password) async {}

  @override
  String? get error => null;
}

void main() {
  late MockSignInViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockSignInViewModel();
  });

  Widget createSignInScreenForTest({MockSignInViewModel? viewModel}) {
    return MaterialApp(
      home: SignInScreen(viewModel: viewModel ?? mockViewModel),
    );
  }

  group('SignInScreen Widget Smoke Test', () {
    testWidgets('화면에 주요 UI 요소들이 존재하는지 확인', (tester) async {
      await tester.pumpWidget(createSignInScreenForTest());

      expect(find.text('Calmi'), findsOneWidget);
      expect(find.text('마음 건강을 위한 따듯한 공간'), findsOneWidget);
      expect(find.text('이메일'), findsOneWidget);
      expect(find.byType(TextFormField).at(0), findsOneWidget); // 이메일 텍스트 필드
      expect(find.text('비밀번호'), findsOneWidget);
      expect(find.byType(TextFormField).at(1), findsOneWidget); // 비밀번호 텍스트 필드
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('로그인'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('회원가입'), findsOneWidget);
    });

    testWidgets('이메일 텍스트 필드에 텍스트를 입력할 수 있는지 확인', (tester) async {
      await tester.pumpWidget(createSignInScreenForTest());

      const testEmail = 'test@example.com';
      await tester.enterText(find.byType(TextFormField).at(0), testEmail);
      expect(find.text(testEmail), findsOneWidget);
    });

    testWidgets('비밀번호 텍스트 필드에 텍스트를 입력할 수 있는지 확인', (tester) async {
      await tester.pumpWidget(createSignInScreenForTest());

      const testPassword = 'password123';
      await tester.enterText(find.byType(TextFormField).at(1), testPassword);
      expect(find.text(testPassword), findsOneWidget);
    });

    testWidgets('로그인 버튼이 탭 가능한 상태인지 확인', (tester) async {
      await tester.pumpWidget(createSignInScreenForTest());
      final loginButton = find.widgetWithText(ElevatedButton, '로그인');
      expect(loginButton, findsOneWidget);
    });

    testWidgets('회원가입 버튼이 탭 가능한 상태인지 확인', (tester) async {
      await tester.pumpWidget(createSignInScreenForTest());
      final signUpButton = find.widgetWithText(TextButton, '회원가입');
      expect(signUpButton, findsOneWidget);
    });
  });
}
