import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/provider/dumy_provider.dart';
import 'package:enebla_user_app/screens/account/contucUs.dart';
import 'package:enebla_user_app/bloc/state.dart';

import 'package:enebla_user_app/screens/home/tabbar.dart';
import 'package:enebla_user_app/theme/style.dart';
import 'package:enebla_user_app/widget/resturant_page_upper_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

import '../chapapayment/chapa_payment initializer.dart';
import '../comment_and_rating.dart';

class ResturantHomePage extends StatefulWidget {
  final snap;

  ResturantHomePage({super.key, required this.snap});

  @override
  State<ResturantHomePage> createState() => _ResturantHomePageState();
}

class _ResturantHomePageState extends State<ResturantHomePage> {
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('=-=-=-=-=-');
    print(widget.snap);
    var subscription_state = 0;
    final state = AppStateProvider.of(context)?.state;

    return Scaffold(
        body: Column(
      children: [
        ResturantPageUpperSlider(),
        Expanded(
          child: Column(
            children: [
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
                        widget.snap['name'],
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),

                    //tag
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: style.Style.resturantTagColor,
                                fontSize: 16),
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
                          builder: (context) => CommentAndRating(
                            commentedby: FirebaseAuth.instance.currentUser!.uid,
                            commentedto: widget.snap['owner'],
                          ),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
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
                                    style: TextStyle(
                                        color: style.Style.SecondaryColor),
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('subscription')
                                          .where('owner',
                                              isEqualTo: widget.snap['owner'])
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        final snapSubscription =
                                            snapshot.data!.docs[0].data();
                                        final min =
                                            snapSubscription['minthreshold'];
                                        final max =
                                            snapSubscription['maxthreshold'];
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              color: style.Style.SecondaryColor,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  min,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'Minimum Threshold',
                                                  style: TextStyle(
                                                      color: style.Style
                                                          .resturantTagColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Icon(
                                              Icons.attach_money,
                                              color: style.Style.SecondaryColor,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  max,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'Maximum Threshold',
                                                  style: TextStyle(
                                                      color: style.Style
                                                          .resturantTagColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
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
              subscription_state != 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        //subscription amount
                        Flexible(
                          child: SizedBox(
                            height: 40,
                            width: 180,
                            child: TextFormField(
                              controller: amountController,
                              // validator: (value) {
                              //   if (int.parse(value!) !> 1000) {
                              //     return ("please enter your email");
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit),
                                  hintText: 'Subscription Amount',
                                  hintStyle: TextStyle(fontSize: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                        //subscription Button
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(left: 13, right: 13),
                                  elevation: 5,
                                  backgroundColor: style.Style.SecondaryColor),
                              onPressed: () {
                                print(amountController);
                                if (int.parse(amountController.text) < 1000) {
                                  ElegantNotification(
                                    title: Text("Error"),
                                    description:
                                        Text(" Enter Amount more than 1000"),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    progressIndicatorColor: Colors.red,
                                  ).show(context);
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('subscriptionuser')
                                      .doc(widget.snap['owner'])
                                      .set({
                                    "subscriptionAmount": amountController.text,
                                    'owner': widget.snap['owner'],
                                    "subscribedUser":
                                        FirebaseAuth.instance.currentUser?.uid
                                  }).then((value) =>
                                          print('subscription user done'));
                                  ElegantNotification(
                                    title: Text("Success"),
                                    description: Text(
                                        "You Have Been Added to Subscription plan."),
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    progressIndicatorColor: Colors.green,
                                  ).show(context);
                                  subscription_state = 1;
                                  Chapa.paymentParameters(
                                    context: context, // context
                                    publicKey:
                                        'CHASECK_TEST-FnTXa03f7dXyGVn0HCyfZFvHgT8j1XJX',
                                    currency: 'ETB',
                                    amount: amountController.text,
                                    email: 'xyz@gmail.com',
                                    firstName: 'firstname',
                                    lastName: 'lastname',
                                    txRef: '34TXTHHgb',
                                    title: 'title',
                                    desc: 'desc',
                                    namedRouteFallBack: '/fallback',
                                    // fall back route name
                                  );
                                }
                              },
                              child: Text(
                                'Subscribe'.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )
                  : Container(
                      child: Text("you are subscribed to this resturant")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('menus')
                          .where('id', isEqualTo: widget.snap['owner'])
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        final PlatformProvidedMenuItemType;
                        if (snapshot.data!.docs.isNotEmpty) {
                          final snap = snapshot.data!.docs[0].data();
                          final menuItem = snap['menulist'];

                          final menuName = menuItem.keys.toList();

                          return TopTabBarWidget(
                            snap: snap,
                            menuItem: menuItem,
                            menuName: menuName,
                          );
                        }

                        //the entire list of menus

                        //menuItem['menuname[index]']['listoffood'][index][name]

                        //title menuname[index]

                        return Center(
                            child: Text(
                                'this resturant does not have a menu yet'));
                      }))
            ],
          ),
        )
      ],
    ));
  }
}
