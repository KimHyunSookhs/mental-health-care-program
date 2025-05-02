import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mental_health_care/presentation/sign_in_screen/sign_in_view_model.dart';

import '../../core/routing/routes.dart';
import '../../core/ui/color_style.dart';
import '../../core/validation/validation_form.dart';
import '../component/button_styles.dart';

class SignInScreen extends StatefulWidget {
  final SignInViewModel viewModel;

  const SignInScreen({super.key, required this.viewModel});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ValidationForm _validationForm = ValidationForm();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: ColorStyle.lightGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Calmi',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text('마음 건강을 위한 따듯한 공간',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
              const SizedBox(
                height: 15,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: ColorStyle.moreDarkGrey)),
                            hintText: '이메일을 입력하세요',
                            hintStyle: TextStyle(
                                color: ColorStyle.moreDarkGrey, fontSize: 12)),
                        // validator: _validationForm.validateEmail,
                      ),
                      const SizedBox(
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: ColorStyle.moreDarkGrey)),
                            hintText: '비밀번호를 입력하세요',
                            hintStyle: TextStyle(
                                color: ColorStyle.moreDarkGrey, fontSize: 12)),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyles.signInButton,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                widget.viewModel.signIn(_emailController.text,
                                    _passwordController.text);
                                context.go(Routes.haruScreen);
                              }
                            },
                            child: Text(
                              '로그인',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    context.push(Routes.signUpScreen);
                  },
                  child: Text('회원가입',
                      style: TextStyle(fontSize: 13, color: Colors.black)))
            ],
          ),
        ),
      )),
    );
  }
}
