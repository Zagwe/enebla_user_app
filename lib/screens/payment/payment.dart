import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Payment_method extends StatelessWidget {
  Payment_method({super.key});
  List<String> homeCardTag = ['chapa', 'yenepay', 'telebirr'];
  List<String> homeCardImage = [
    "lib/assets/chapa.jpg",
    "lib/assets/telebirr.jpg",
    "lib/assets/yenepay.png"
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
                    'available payment methods',
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
                      'current status',
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    homeCardTag[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                        wordSpacing: 5),
                                  ),
                                  // const  Flexible(
                                  //     child: Text(
                                  //       'Shortbread, chocolate turtle cookies, and red velvet.',
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.w800,
                                  //           color: Colors.black54,
                                  //           // wordSpacing: 5
                                  //       ),
                                  //     ),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Text(
                                        'Ethiopia',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        'active',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.green,
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
