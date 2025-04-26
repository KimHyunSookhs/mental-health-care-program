import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mental_health_care/core/di/di_setup.dart';
import 'package:mental_health_care/core/firebase/firebase_options.dart';

import 'core/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: 'assets/env/.env');
  diSetUp();

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
