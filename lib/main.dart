import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/another_style.dart' as style;

//added some comment

import 'enebla_user_home.dart';

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

class Trail extends StatefulWidget {
  const Trail({super.key});

  @override
  State<Trail> createState() => _TrailState();
}

class _TrailState extends State<Trail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(children: []),
      ),
    );
  }
}
