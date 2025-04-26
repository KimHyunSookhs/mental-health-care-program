import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/presentation/component/button_styles.dart';

import '../../core/routing/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.self_improvement,
                size: 99,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Calmi',
                style: TextStyle(fontSize: 40),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  '혼자가 아니에요',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              FittedBox(
                child: Text(
                  '당신의 이야기를 들어줄게요',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.go(Routes.signInScreen);
                  },
                  style: ButtonStyles.signInButton,
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('처음이신가요?',
                      style: TextStyle(fontSize: 12, color: Colors.black87)),
                  TextButton(
                      onPressed: () {
                        context.go(Routes.signUpScreen);
                      },
                      child: Text('가입하기',
                          style: TextStyle(fontSize: 13, color: Colors.black)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
