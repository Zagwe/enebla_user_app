import 'package:http/http.dart';

class Unsubscribe {
  final String resturantId;
  final String userId;
  final String currentBalance;
  final String subscriptionAmount;
  final String complinet;

  Unsubscribe(
      {required this.complinet,
      required this.currentBalance,
      required this.resturantId,
      required this.subscriptionAmount,
      required this.userId});

  Map<String, dynamic> toJson() => {
        "resturantId": resturantId,
        "userId": userId,
        "currentBalance": currentBalance,
        "subscriptionAmount": subscriptionAmount,
        "complinet": complinet
      };
}
