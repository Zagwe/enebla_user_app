import 'package:enebla_user_app/screens/home/tabbar.dart';
import 'package:enebla_user_app/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:enebla_user_app/another_style.dart' as style;

import 'enebla_home.dart';

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
      debugShowCheckedModeBanner: false,
      theme: style.Style.themeData,
      home: EneblaHome(),
    );
  }
}
