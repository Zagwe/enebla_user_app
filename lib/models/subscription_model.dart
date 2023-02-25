import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String subscriptionAmount;
  final String subscriptionstatus;
  final String subscribedUser;
  final String subscribtionOwner;

  SubscriptionModel(
      {required this.subscriptionAmount,
        required this.subscriptionstatus,
        required this.subscribedUser,
        required this.subscribtionOwner
      });

  Map<String, dynamic> toJson() {
    return {
      subscribedUser: {
        'subscriptionAmount': subscriptionAmount,
        'subscriptionstatus': subscriptionstatus,
        'subscribedUser': subscribedUser,
        'subscribtionOwner': subscribtionOwner
      }
    };
  }

  factory SubscriptionModel.fromMap(Map) {
    return SubscriptionModel(
        subscriptionAmount: Map['subscriptionAmount'],
        subscriptionstatus: Map['subscriptionstatus'],
        subscribedUser: Map['subscribedUser'],
        subscribtionOwner: Map['subscribtionOwner']);
  }
}
