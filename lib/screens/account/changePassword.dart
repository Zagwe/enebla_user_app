import 'package:enebla_user_app/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:enebla_user_app/screens/account/accountSetting.dart';

import '../../enebla_user_home.dart';

class BackupSettings extends StatefulWidget {
  @override
  _BackupSettingsState createState() => _BackupSettingsState();
}

class _BackupSettingsState extends State<BackupSettings> {
  final _newpasswordController = TextEditingController();
  final _repeatpasswordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  void _changePassword(String currentPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user.email, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
      }).catchError((error) {
        //Error, show something
      });
    }).catchError((err) {});
  }

  bool checkCurrentPasswordValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ('backup_text'),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => AccountSetting()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            key: _formKey,
            children: <Widget>[
              Container(
                child: TextFormField(
                    validator: (input) {
                      if (input!.length < 8)
                        return 'Please Provide Minimum 8 Character';
                    },
                    decoration: InputDecoration(
                      labelText: "new_password",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    obscureText: true,
                    controller: _newpasswordController),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'repeat_password',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                  controller: _repeatpasswordController,
                  validator: (value) {
                    return _newpasswordController.text == value
                        ? null
                        : "Please validate your entered password";
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                // padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                onPressed: () {},

                child: Text(('save_button'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
