import 'package:flutter/cupertino.dart';

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
          message = args['message'];
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
    return Center(
      child: Center(child: Text(message)),
    );
  }
}
