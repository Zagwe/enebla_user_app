import 'dart:convert';
import 'dart:math';
import 'package:chapasdk/constants/url.dart';
import 'package:enebla_user_app/screens/chapapayment/fallback.dart';
import 'package:enebla_user_app/screens/subscription/subscripion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../chapawebview.dart';
import '../model/data.dart';
var intValue;
Future<String> getRef() async{
   intValue = Random().nextInt(1000000) + 1000000;

  return intValue.toString();
}

Future<String> intilizeMyPayment(
  BuildContext context,
  String authorization,
  String email,
  String amount,
  String currency,
  String firstName,
  String lastName,
  String transactionReference,
  String customTitle,
  String customDescription,
  String fallBackNamedRoute,
) async {
  getRef();
  final http.Response response = await http.post(
    Uri.parse(ChapaUrl.baseUrl),
    headers: {
      'Authorization': 'Bearer $authorization',
    },
    body: {
      'email': email,
      'amount': amount,
      'currency': currency.toUpperCase(),
      'first_name': firstName,
      'last_name': lastName,
      'tx_ref': intValue.toString(),
      'customization[title]': customTitle,
      'customization[description]': customDescription
    },
  );
  var jsonResponse = json.decode(response.body);
  if (response.statusCode == 400) {
    print(jsonResponse);

  } else if (response.statusCode == 200) {
    ResponseData res = ResponseData.fromJson(jsonResponse);
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Good &&&&&");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChapaWebView(
                url: res.data.checkoutUrl.toString(),
                fallBackNamedUrl: fallBackNamedRoute,
                transactionReference: transactionReference,
                amountPaid: amount,
              )),
    );

    return res.data.checkoutUrl.toString();
  }
  print('broo2');
  return '';
}

// Future<bool?> showToast(jsonResponse) {
//   return Fluttertoast.showToast(
//       msg: jsonResponse['message'],
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }
