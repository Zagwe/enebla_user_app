import 'package:flutter/material.dart';

import 'package:enebla_user_app/theme/style.dart' as style;

class Style {
  static var appBarTheme = const AppBarTheme(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 80);
  static var textTheme = TextTheme(
      headlineLarge: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
      headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black));

  static var tabbarTheme = TabBarTheme(
      indicator: UnderlineTabIndicator(
          // insets: EdgeInsets.only(right: 60.0, left: 16, top: 50),
          borderSide: BorderSide(width: 5, color: style.Style.primaryColor)),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black26,
      unselectedLabelStyle: TextStyle(fontSize: 20),
      labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  static var themeData = ThemeData(
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      )),
      textTheme: Style.textTheme,
      appBarTheme: Style.appBarTheme,
      tabBarTheme: Style.tabbarTheme,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white);
}
