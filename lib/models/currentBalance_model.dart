import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentBalanceModel {
  final String currentBalance;
  final String subscribedUser;
  final String subscribtionOwner;

  CurrentBalanceModel(
      {required this.currentBalance,
      required this.subscribedUser,
      required this.subscribtionOwner});

  Map<String, dynamic> toJson() {
    return {
      subscribedUser: {
        'currentBalance': currentBalance,
        'subscribedUser': subscribedUser,
        'subscribtionOwner': subscribtionOwner
      }
    };
  }

  factory CurrentBalanceModel.fromMap(Map) {
    return CurrentBalanceModel(
        currentBalance: Map['currentBalance'],
        subscribedUser: Map['subscribedUser'],
        subscribtionOwner: Map['subscribtionOwner']);
  }
}
