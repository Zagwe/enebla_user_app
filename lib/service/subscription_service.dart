import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/models/comment_model.dart';
import 'package:enebla_user_app/models/unsubscribe.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/currentBalance_model.dart';
import '../models/subscription_model.dart';

class SubscriptionService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addSubscription({
    required String subscriptionAmount,
    required String subscriptionstatus,
    required String subscribedUser,
    required String subscribtionOwner,
    required String currentBalance,
  }) async {
    String res = '';
    SubscriptionModel subscriptionModel = SubscriptionModel(
      subscriptionAmount: subscriptionAmount,
      subscriptionstatus: subscriptionstatus,
      subscribedUser: subscribedUser,
      subscribtionOwner: subscribtionOwner,
      currentBalance: currentBalance,
    );

    await _firestore
        .collection('subscriptionuser')
        .doc(subscribtionOwner)
        .set(subscriptionModel.toJson(), SetOptions(merge: true))
        .then((value) {
      res = 'subscription added successfully';
    }).onError((error, stackTrace) {
      res = error.toString();
    });

    return res;
  }

  unsubscribe(
      {required complinet,
      required resturantId,
      required userId,
      required currentBalance,
      required subscriptionAmount}) {
    Unsubscribe unsubscribe = Unsubscribe(
        currentBalance: currentBalance,
        resturantId: resturantId,
        subscriptionAmount: subscriptionAmount,
        userId: userId,
        complinet: complinet);

    FirebaseFirestore.instance
        .collection('unsubscribecomplient')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(unsubscribe.toJson())
        .then((value) => print('request sent'));
    // print(subscriptionAmount);
    // print(resturantId);
  }
}
