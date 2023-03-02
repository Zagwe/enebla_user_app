import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/colors.dart';
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
  final newController = TextEditingController();
  final confirmController = TextEditingController();
  final oldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  _changePassword(String yourPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    final String verify = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: oldController.text)
        .then((value) => 'success')
        .onError((error, stackTrace) {
      ElegantNotification(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .2,
        title: const Text("incorrect password"),
        description: Text(error.toString()),
        icon: const Icon(
          Icons.warning,
          color: Colors.green,
        ),
        progressIndicatorColor: Colors.green,
      ).show(context);
      return error.toString();
    });
    if (verify == 'success') {
      user!.updatePassword(yourPassword).then((value) {
        print('update done');
        ElegantNotification(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * .5,
          title: const Text("password updated"),
          description: const Text(''),
          icon: const Icon(
            Icons.done,
            color: Colors.green,
          ),
          progressIndicatorColor: Colors.green,
        ).show(context);
      }).catchError((error) {
        print(error.toString());
        // print("Error " + error.toString());
      });
    }
  }

  Widget makeTextFeild(
      {required controller,
      required labletext,
      required validator,
      required passwordVisible,
      iconbutton}) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: iconbutton,
          labelText: labletext,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.black,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        obscureText: !passwordVisible,
        controller: controller);
  }

  bool checkCurrentPasswordValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'change password'.toUpperCase(),
          style: TextStyle(color: style.Style.primaryColor),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              makeTextFeild(
                controller: oldController,
                labletext: 'old passwrod',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Provide your old password';
                  }
                  return null;
                },
                passwordVisible: true,
              ),
              makeTextFeild(
                  controller: newController,
                  labletext: 'new password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please provide your new password';
                    } else if (value.length < 6) {
                      return 'password should have atleast 6 characters';
                    }
                  },
                  iconbutton: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  passwordVisible: _passwordVisible),
              makeTextFeild(
                  controller: confirmController,
                  labletext: 'confirm password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please confirm your new password';
                    } else if (newController.text != confirmController.text) {
                      return 'this value does not match your new password';
                    }
                  },
                  iconbutton: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  passwordVisible: _passwordVisible),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      // padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(('cancel'),
                          style: TextStyle(
                              color: Colors.white,
                              // fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      // padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _changePassword(newController.text);
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(('change'),
                          style: TextStyle(
                              color: Colors.white,
                              // fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              // Spacer(
              //   flex: 2,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
