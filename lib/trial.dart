import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Trial extends StatelessWidget {
  const Trial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('subscription').snapshots(),
          builder: (context, snapshot) {
            final snap = snapshot.data!.docs[0].data();
            print('==-==-=-=--');

            print(snap.keys.toList());

            print(snap.values.toList());
            print(snap['owner']);

            print(snap['maxthreshold ']);
            print(snap['minthreshold']);

            return Center(
              child: Container(
                child: Text('dome'),
              ),
            );
          }),
    );
  }
}
