import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_care/core/di/di_setup.dart';

import 'core/routing/router.dart';
import 'firebase_options.dart';

void main() async {
  diSetUp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Calmi());
}

class Calmi extends StatelessWidget {
  const Calmi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: '42dotSans'),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
