import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/models/currentBalance_model.dart';
import 'package:enebla_user_app/models/subscription_model.dart';


class BalanceService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  setCurrentBalance({
    required String totalBalance,
    required String subscribtionOwner,
    required String subscribtionUser,
  }) async {
    String res = '';
    _firestore.collection('subscriptionuser').doc(subscribtionOwner).set({
      subscribtionUser: {"currentBalance": totalBalance}
    }, SetOptions(merge: true)).then((value) {
      res = 'balance of current added successfully';
    }).onError((error, stackTrace) {
      res = error.toString();
    });

    return res;
  }
}
