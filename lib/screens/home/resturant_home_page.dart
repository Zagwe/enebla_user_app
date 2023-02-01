import 'package:enebla_user_app/provider/dumy_provider.dart';
import 'package:enebla_user_app/screens/home/tabbar.dart';
import 'package:enebla_user_app/style.dart';
import 'package:enebla_user_app/widget/resturant_page_upper_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:enebla_user_app/style.dart' as style;

import '../comment_and_rating.dart';

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

        ////resturant information section
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //resturant name
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Resturant name',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),

              //tag
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: style.Style.resturantTagColor, fontSize: 16),
                      children: const [
                    TextSpan(text: '\$\$'),
                    TextSpan(text: ' \u2981 '),
                    TextSpan(text: 'chicken'),
                    TextSpan(text: ' \u2981 '),
                    TextSpan(text: 'America'),
                    TextSpan(text: ' \u2981  '),
                    TextSpan(text: 'Deshi Food'),
                  ])),
              const SizedBox(
                height: 10,
              ),
              //rating
              GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                    expand: false,
                    context: context,
                    bounce: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => CommentAndRating(),
                  );
                },
                child: Row(
                  children: [
                    Row(
                      children: [
                        //rating
                        Row(
                          children: [
                            //rating value
                            Text('4.5'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color: style.Style.SecondaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            //rated people count
                            Text(
                              '200+ Rating',
                              style:
                                  TextStyle(color: style.Style.SecondaryColor),
                            ),
                          ],
                        ),
                        //separetor

                        //comment
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        ////subscription seciton
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //subscription amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.attach_money,
                  color: style.Style.SecondaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1000',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Subscription Amount',
                      style: TextStyle(
                          color: style.Style.resturantTagColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            //subscription Button
            Container(
              width: 150,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(13),
                      elevation: 5,
                      backgroundColor: style.Style.SecondaryColor),
                  onPressed: () {},
                  child: Text(
                    'Subscribe'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Menu',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: style.Style.primaryColor),
            ),
          ),
        ),
        //food menu tab bar
        Expanded(child: TopTabBarWidget())
      ],
    ));
  }
}
