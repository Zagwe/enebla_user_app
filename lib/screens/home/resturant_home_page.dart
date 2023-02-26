import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/bloc/state.dart';

import 'package:enebla_user_app/screens/home/tabbar.dart';
import 'package:enebla_user_app/screens/subscription/subscripion.dart';

import 'package:enebla_user_app/widget/resturant_page_upper_slider.dart';
import 'package:enebla_user_app/widget/subscription_treshold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:enebla_user_app/theme/style.dart' as style;

import '../../service/subscription_service.dart';
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

  String isButtonActive = "";

  // @override
  // void initState() {
  //   checkSuscription();
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // print('=-=-=-=-=-');
    // print(widget.snap);
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
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
                                  const Text('4.5'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                      color: style.Style.SecondaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  //rated people count
                                  Text(
                                    '200+ Rating',
                                    style: TextStyle(
                                        color: style.Style.SecondaryColor),
                                  ),

                                  ///THIS SHOWS THE MAXIMUM AND THE MINUMUM TRESHOLD
                                  // SubscriptionTreshold(snap: widget.snap)

                                  ///END
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
              SubscriptionTreshold(snap: widget.snap),

              ///
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubscriptionInfromation(snap: widget.snap),
              ),

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

                        return const Center(
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
