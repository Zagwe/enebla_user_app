import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:enebla_user_app/screens/account/accountSetting.dart';

import '../../enebla_user_home.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("about us"));
  }
}
