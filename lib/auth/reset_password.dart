import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
