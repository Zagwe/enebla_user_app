import 'package:flutter/material.dart';


class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Center(
          child: Text(
              'Your Orders',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  wordSpacing: 5
              )
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('first'),
              Text('Second')
              
            ],
          )
        ]
      )
    );
  }
}
