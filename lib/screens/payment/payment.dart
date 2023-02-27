import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Payment_method extends StatelessWidget {
  Payment_method({super.key});
  List<String> homeCardTag = [
    'Chapa',
    'Telebirr',
    'Yenepay',
    'Stripe',
    'Paypal'
  ];
  List<String> activeStatus = [
    'Active',
    'Comming Soon',
    'Comming Soon',
    'Comming Soon',
    'Comming Soon'
  ];
  List<String> homeCardImage = [
    "lib/assets/chapa.jpg",
    "lib/assets/telebirr.jpg",
    "lib/assets/yenepay.png",
    "lib/assets/stripe.png",
    "lib/assets/paypal.png"
  ];

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
            child: Text('payment methods',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    wordSpacing: 5)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Available payment methods',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      //  Navigator.of(context).push(MaterialPageRoute(
                      //      builder: (BuildContext context) => EneblaHome()));
                    },
                    child: Text(
                      'Current Status',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: homeCardTag.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                                image: AssetImage(homeCardImage[index]),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    homeCardTag[index],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                        wordSpacing: 5),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Ethiopia',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        activeStatus[index],
                                        style: TextStyle(
                                          // backgroundColor: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: activeStatus[index] == 'Active'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
