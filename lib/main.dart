import 'package:flutter/material.dart';

void main() {
  runApp(EneblaUser(
    title: 'enebla user app',
  ));
}

class EneblaUser extends StatelessWidget {
  String title;
  EneblaUser({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 66, 204),
          title: Text(title)),
    ));
  }
}
