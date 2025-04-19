import 'package:flutter/material.dart';

class HaruButton extends StatelessWidget {
  const HaruButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text('하루 완료'));
  }
}
