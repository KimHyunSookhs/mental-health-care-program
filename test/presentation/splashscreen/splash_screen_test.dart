import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mental_health_care/core/ui/button_style.dart';
import 'package:mental_health_care/presentation/splashscreen/splash_screen.dart';

void main() {
  Widget createSplashScreenForTest() {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }

  group('SplashScreen - 위젯 존재 및 스타일 확인', () {
    testWidgets('화면에 주요 UI 요소들이 존재하는지 확인', (tester) async {
      await tester.pumpWidget(createSplashScreenForTest());

      expect(find.byIcon(Icons.self_improvement), findsOneWidget);
      expect(find.text('Calmi'), findsOneWidget);
      expect(find.text('혼자가 아니에요'), findsOneWidget);
      expect(find.text('당신의 이야기를 들어줄게요'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('로그인'), findsOneWidget);
      expect(find.text('처음이신가요?'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('가입하기'), findsOneWidget);
    });

    testWidgets('로그인 버튼 텍스트와 스타일이 올바른지 확인', (tester) async {
      await tester.pumpWidget(createSplashScreenForTest());

      final loginButton = tester
          .widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '로그인'));
      expect(loginButton.style, ButtonStyles.signInButton);
      expect(loginButton.child, isA<Text>());
      expect((loginButton.child as Text).data, '로그인');
      expect((loginButton.child as Text).style?.color, Colors.white);
    });

    testWidgets('가입하기 버튼 텍스트와 스타일이 올바른지 확인', (tester) async {
      await tester.pumpWidget(createSplashScreenForTest());

      final signUpButton =
          tester.widget<TextButton>(find.widgetWithText(TextButton, '가입하기'));
      expect(signUpButton.child, isA<Text>());
      expect((signUpButton.child as Text).data, '가입하기');
      expect((signUpButton.child as Text).style?.color, Colors.black);
    });
  });
}
