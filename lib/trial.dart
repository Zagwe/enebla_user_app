import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Trial extends StatelessWidget {
  final snap;
  const Trial({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    // final String user = FirebaseAuth.instance.currentUser!.uid.toString();
    // print(user);
    // final String userr = 'roaRptCVACSv9YHjHFFMGIVHjqr1';

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('subscriptionuser')
              .doc(snap['owner'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!
                      .data()![FirebaseAuth.instance.currentUser!.uid] ==
                  null) {
                //user hasent subscribed so show the clickeble button
              } else {
                ///user has subscribed to this resturant so button shouldn't be clickable
              }
            }

            ///for the threshold
            // final snap;

            // if (snapshot.data != null) {
            //   snap = snapshot.data!.docs[0].data();
            // } else {
            //   snap = Map();
            // }
            // print('==-==-=-=--');

            // print(snap.keys.toList());
            // print(FirebaseAuth.instance.currentUser!.uid);
            // print(snap.values.toList());
            // print(snap['owner']);

            // print(snap['maxthreshold ']);
            // print(snap['minthreshold']);

            // return Center(child: CircularProgressIndicator());

            return CircularProgressIndicator();
          }),
    );
  }
}
