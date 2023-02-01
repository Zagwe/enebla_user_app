import 'package:flutter/material.dart';

class reset_password extends StatefulWidget {
  const reset_password({super.key});

  @override
  State<reset_password> createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Text("forgot password"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.5),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(),
              ),
            )
          ],
        ));
  }
}
