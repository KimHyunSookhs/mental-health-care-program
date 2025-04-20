import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
