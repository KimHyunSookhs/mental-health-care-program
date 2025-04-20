import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/core/routing/routes.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_view_model.dart';

import '../component/button_styles.dart';

class SignupScreen extends StatefulWidget {
  final SignUpViewModel viewModel;

  const SignupScreen({super.key, required this.viewModel});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.signUp(_emailController.text, _passwordController.text);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorStyle.lightGrey,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calmi',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text('마음 건강을 위한 따듯한 공간',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이메일',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorStyle.moreDarkGrey)),
                  hintText: '이메일을 입력하세요',
                  hintStyle:
                      TextStyle(color: ColorStyle.moreDarkGrey, fontSize: 12)),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '닉네임',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorStyle.moreDarkGrey)),
                  hintText: '닉네임을 입력하세요',
                  hintStyle:
                      TextStyle(color: ColorStyle.moreDarkGrey, fontSize: 12)),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorStyle.moreDarkGrey)),
                  hintText: '비밀번호를 입력하세요',
                  hintStyle:
                      TextStyle(color: ColorStyle.moreDarkGrey, fontSize: 12)),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호 확인',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorStyle.moreDarkGrey)),
                  hintText: '비밀번호를 다시 입력하세요',
                  hintStyle:
                      TextStyle(color: ColorStyle.moreDarkGrey, fontSize: 12)),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyles.signInButton,
                  onPressed: () {
                    widget.viewModel.signUp(
                        _emailController.text, _passwordController.text);
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('이미 계정이 있으신가요?',
                    style: TextStyle(fontSize: 12, color: Colors.black87)),
                TextButton(
                    onPressed: () {
                      context.go(Routes.signInScreen);
                    },
                    child: Text('로그인',
                        style: TextStyle(fontSize: 13, color: Colors.black)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
