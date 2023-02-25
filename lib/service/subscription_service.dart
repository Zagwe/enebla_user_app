import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/models/comment_model.dart';

import '../models/subscription_model.dart';

class SubscriptionService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addSubscription(
      {required String subscriptionAmount,
        required String subscriptionstatus,
        required String subscribedUser,
        required String subscribtionOwner}) async {
    String res = '';
    SubscriptionModel subscriptionModel = SubscriptionModel(
        subscriptionAmount: subscriptionAmount, subscriptionstatus: subscriptionstatus, subscribedUser: subscribedUser,subscribtionOwner: subscribtionOwner);

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
}
