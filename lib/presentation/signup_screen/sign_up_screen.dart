import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/core/routing/routes.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/core/validation/validation_form.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_view_model.dart';

import '../../core/ui/button_style.dart';

class SignupScreen extends StatefulWidget {
  final SignUpViewModel viewModel;

  const SignupScreen({super.key, required this.viewModel});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValidationForm _validationForm = ValidationForm();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _nickNameController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            color: ColorStyle.lightGrey,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Calmi',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Text('마음 건강을 위한 따듯한 공간',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '이메일',
                    ),
                  ),
                  TextFormField(
                    focusNode: _emailFocus,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: ColorStyle.moreDarkGrey)),
                        hintText: '이메일을 입력하세요',
                        hintStyle: TextStyle(
                            color: ColorStyle.moreDarkGrey, fontSize: 12)),
                    validator: _validationForm.validateEmail,
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
                  TextFormField(
                    controller: _nickNameController,
                    validator: _validationForm.validateNickname,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: ColorStyle.moreDarkGrey)),
                        hintText: '닉네임을 입력하세요',
                        hintStyle: TextStyle(
                            color: ColorStyle.moreDarkGrey, fontSize: 12)),
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
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: true,
                    validator: _validationForm.validatePassword,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: ColorStyle.moreDarkGrey)),
                        hintText: '비밀번호를 입력하세요',
                        hintStyle: TextStyle(
                            color: ColorStyle.moreDarkGrey, fontSize: 12)),
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
                  TextFormField(
                    obscureText: true,
                    controller: _passwordConfirmController,
                    validator: (value) =>
                        _validationForm.validatePasswordConfirmation(
                            value, _passwordController.text),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: ColorStyle.moreDarkGrey)),
                        hintText: '비밀번호를 다시 입력하세요',
                        hintStyle: TextStyle(
                            color: ColorStyle.moreDarkGrey, fontSize: 12)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyles.signInButton,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            widget.viewModel.signUp(
                                _emailController.text,
                                _passwordController.text,
                                _nickNameController.text);
                            context.push(Routes.signInScreen);
                          }
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
                          style:
                              TextStyle(fontSize: 12, color: Colors.black87)),
                      TextButton(
                          onPressed: () {
                            context.push(Routes.signInScreen);
                          },
                          child: Text('로그인',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
