import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/screens/account/subscripion/subscribed_resurant_detail.dart';
import 'package:enebla_user_app/theme/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // backgroundColor: Colors.blue,
        backgroundColor: Colors.grey.shade300,
        toolbarHeight: 150,
        elevation: 0,
        leading: Align(
          alignment: Alignment.topLeft,
          child: BackButton(
            color: style.Style.primaryColor,
          ),
        ),
        title: Text(
          "subscribed\nresturants".toUpperCase(),
          style: TextStyle(
              // fontSize: 24,
              fontWeight: FontWeight.bold,
              color: style.Style.primaryColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('subscriptionuser')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            int length = 0;
            for (int index = 0; index < snapshot.data!.docs.length; index++) {
              // print(snapshot.data!.docs[index].data().keys);
              final keys = snapshot.data!.docs[index].data().keys.toList();

              for (var j = 0; j < keys.length; j++) {
                if (FirebaseAuth.instance.currentUser!.uid == keys[j]) {
                  // print('you are subscribed');
                  // print(keys);
                  length++;
                }
              }
            }

            // print(snapshot.data!.docs[0].data().keys.toList());
            return ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                final singleDoc = snapshot.data!.docs[index]
                    [FirebaseAuth.instance.currentUser!.uid];
                // print(singleDoc);
                String resturant = singleDoc['subscribtionOwner'];
                // print(singleDoc);

                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('resturant')
                      .doc(resturant)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data() != null) {
                        final resturantInfo = snapshot.data!.data();
                        // print(resturantInfo!['imageUrl']);
                        final currentBalance = singleDoc['currentBalance'];
                        final resturantName = resturantInfo!['name'];
                        // print(resturantInfo);

                        final resturantId = singleDoc['subscribtionOwner'];
                        final subscriptionAmount =
                            singleDoc['subscriptionAmount'];
                        return GestureDetector(
                          onTap: () {
                            showBarModalBottomSheet(
                                expand: false,
                                context: context,
                                bounce: true,
                                backgroundColor: Colors.white,
                                builder: (context) => SubscribedResturantDetail(
                                      currentBalance: currentBalance,
                                      name: resturantName,
                                      imageUrl: resturantInfo['imageUrl'],
                                      resturantId: resturantId,
                                      subscriptionAmount: subscriptionAmount,
                                    )

                                ///this page will show
                                ///
                                ///the user name
                                ///
                                ///subscription amount
                                ///
                                ///balance
                                ///
                                ///subscription date
                                ///
                                ///order history

                                );
                          },
                          child: Container(
                            margin: EdgeInsets.all(12),
                            // margin: EdgeInsets.all(12),
                            child: Material(
                              elevation: 20,
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(12),
                                // height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(width: 2)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    resturantInfo['imageUrl'] is String
                                        ? CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              resturantInfo['imageUrl'],
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'resturant name   '.toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              resturantInfo['name']
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  'currentBalance   '
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                              Text(
                                                singleDoc['currentBalance'],
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                'subscription amount   '
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Text(
                                              singleDoc['subscriptionAmount'],
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: Icon(Icons.arrow_forward_ios))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return Container();
                    // print(resturant);
                    // print(snapshot.data!.data());
                  },
                );
              },
            );
          }
          return Text('xon');
        },
      ),
    );
  }
}
