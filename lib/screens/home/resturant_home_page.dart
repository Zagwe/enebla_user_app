import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/bloc/state.dart';

import 'package:enebla_user_app/screens/home/tabbar.dart';
import 'package:enebla_user_app/screens/subscription/subscripion.dart';

import 'package:enebla_user_app/screens/home/widget/resturant_page_upper_slider.dart';
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

  var args;
  String message = "";

  String isButtonActive = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (ModalRoute.of(context)?.settings.arguments != null) {
          args = ModalRoute.of(context)?.settings.arguments;
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after payment ");
          message = args['message'];
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(message);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(args['transactionReference']);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(args['paidAmount']);
        }
      });
    });
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ////resturant information section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.snap['name'].toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: style.Style.primaryColor,
                              fontSize: 20),
                        ),
                      ),
                    ),

                    SubscriptionTreshold(snap: widget.snap),
                    SizedBox(
                      height: 15,
                    ),

                    ///
                    SubscriptionInfromation(snap: widget.snap, args: args),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Menu',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: style.Style.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              //food menu tab bar
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('menus')
                          .doc(widget.snap['owner'])
                          // .where('id', isEqualTo: widget.snap['owner'])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.data() != null) {
                            final snap = snapshot.data!.data();
                            // print(snap);
                            final menuItem = snap!['menulist'];

                            final menuName = menuItem.keys.toList();

                            return TopTabBarWidget(
                              snap: snap,
                              menuItem: menuItem,
                              menuName: menuName,
                            );
                          }
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
