import 'package:flutter/material.dart';
import 'package:mental_health_care/presentation/signup_screen/sign_up_view_model.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('회원가입'),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'PassWord'),
          ),
          ElevatedButton(
              onPressed: () {
                widget.viewModel
                    .signUp(_emailController.text, _passwordController.text);
              },
              child: Text('회원가입'))
        ],
      ),
    );
  }
}
