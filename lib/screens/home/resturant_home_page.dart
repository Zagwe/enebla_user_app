import 'package:enebla_user_app/provider/dumy_provider.dart';
import 'package:enebla_user_app/style.dart';
import 'package:enebla_user_app/widget/resturant_page_upper_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:enebla_user_app/style.dart' as style;

class ResturantHomePage extends StatefulWidget {
  const ResturantHomePage({super.key});

  @override
  State<ResturantHomePage> createState() => _ResturantHomePageState();
}

class _ResturantHomePageState extends State<ResturantHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ResturantPageUpperSlider(),
      ],
    ));
  }
}
