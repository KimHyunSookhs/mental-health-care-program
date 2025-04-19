import 'package:flutter/material.dart';
import 'package:mental_health_care/core/di/di_setup.dart';

import 'core/routing/router.dart';

void main() {
  diSetUp();
  runApp(Calmi());
}

class Calmi extends StatelessWidget {
  const Calmi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
