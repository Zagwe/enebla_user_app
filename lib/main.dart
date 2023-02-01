import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/another_style.dart' as style;

import 'enebla_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const EneblaUser());
}

class EneblaUser extends StatelessWidget {
  const EneblaUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: style.Style.themeData,
      home: const EneblaHome(),
    );
  }
}
