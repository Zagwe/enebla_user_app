import 'package:enebla_user_app/screens/account/accountSetting.dart';
// import 'package:enebla_user_app/screens/home/scroll_page.dart';
import 'package:enebla_user_app/screens/onboarding/onBoarding.dart';
import 'package:enebla_user_app/screens/order/order.dart';
import 'package:enebla_user_app/screens/order/orderPreview.dart';
import 'package:enebla_user_app/widget/homepage_slider.dart';
import 'package:enebla_user_app/widget/resturant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:enebla_user_app/style.dart' as style;

import '../../auth/login.dart';
import '../search/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enebla',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: style.Style.primaryColor),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => OnBording()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
            )
          ]),

      ////experimentaing on home page scroll bar
      ///still have alots of work to do on the scroll bar

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            HomePageSlider(),
            Container(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ResturantItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
