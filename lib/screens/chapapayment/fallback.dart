import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../enebla_user_home.dart';

class Fallback extends StatefulWidget {
  Fallback({
    Key? key,
  }) : super(key: key);

  @override
  State<Fallback> createState() => _FallbackState();
}

class _FallbackState extends State<Fallback> {
  var args;
  String message = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (ModalRoute.of(context)?.settings.arguments != null) {
          args = ModalRoute.of(context)?.settings.arguments;
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after payment ");
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(message);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(args['transactionReference']);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(args['paidAmount']);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        color: message == "paymentSuccessful"
            ? Color.fromARGB(255, 2, 101, 230)
            : Color.fromARGB(255, 230, 2, 2),
        child: Column(children: [
          Image.asset('lib/assets/home.png'),
          SizedBox(
            height: 30,
          ),
          Text(
            message == "paymentSuccessful"
                ? message.toUpperCase()
                : "PAYMENTFAILD",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
              message == "paymentSuccessful"
                  ? 'Payment processed successfully, thank you for your Subscription!'
                  : 'Payment processed Faild, please try again!',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          SizedBox(
            height: 60,
          ),
          Container(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  message == "paymentSuccessful" ?
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EneblaHome()))
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EneblaHome()));
                },
                child: Text(message == "paymentSuccessful"
                    ? 'Continue to order'
                    : 'Back'),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 4, 100, 224)),
                    backgroundColor: MaterialStateProperty.all(Colors.white))),
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    ));
  }
}
