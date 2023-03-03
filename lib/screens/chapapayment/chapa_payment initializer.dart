import 'package:flutter/material.dart';

import 'constants/requests.dart';
import 'constants/strings.dart';

class Chapa {
  BuildContext context;
  String publicKey;
  String amount;
  String currency;
  String email;
  String firstName;
  String lastName;
  String txRef;
  String title;
  String desc;
  String namedRouteFallBack;

  Chapa.paymentParameters({
    required this.context,
    required this.publicKey,
    required this.currency,
    required this.amount,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.txRef,
    required this.title,
    required this.desc,
    required this.namedRouteFallBack,
  }) {
    _validateKeys();
    currency = currency.toUpperCase();
    if (_validateKeys()) {
      initatePayment();
    }
  }

  bool _validateKeys() {
    if (publicKey.trim().isEmpty) {
      print(ChapaStrings.publicKeyRequired);
      return false;
    }
    if (currency.trim().isEmpty) {
      print(ChapaStrings.currencyRequired);
      return false;
    }
    if (amount.trim().isEmpty) {
      print(ChapaStrings.amountRequired);
      return false;
    }
    if (email.trim().isEmpty) {
      print(ChapaStrings.emailRequired);
      return false;
    }

    if (firstName.trim().isEmpty) {
      print(ChapaStrings.firstNameRequired);
      return false;
    }
    if (lastName.trim().isEmpty) {
      print(ChapaStrings.lastNameRequired);
      return false;
    }
    if (txRef.trim().isEmpty) {
      print(ChapaStrings.transactionRefrenceRequired);
      return false;
    }

    return true;
  }

  // txRef
  void initatePayment() async {
    await intilizeMyPayment(context, publicKey, email, amount, currency,
        firstName, lastName, title, txRef, desc, namedRouteFallBack);
    print("broo0");
  }
}
