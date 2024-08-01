import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/Admin/admin_login.dart';
import 'package:workers_app/Splash.dart';
import 'package:workers_app/User/user_login.dart';
import 'package:workers_app/onboard.dart';
import 'package:workers_app/workers/work_home.dart';
import 'package:workers_app/workers/work_login.dart';

import 'firebase_options.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
