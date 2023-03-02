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
import 'package:rate_my_app/rate_my_app.dart';

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
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                subscriptionSnapshot) {
          if (subscriptionSnapshot.hasData) {
            int length = 0;
            for (int index = 0;
                index < subscriptionSnapshot.data!.docs.length;
                index++) {
              // print(snapshot.data!.docs[index].data().keys);
              final keys =
                  subscriptionSnapshot.data!.docs[index].data().keys.toList();

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
                final singleDoc = subscriptionSnapshot.data!.docs[index]
                    [FirebaseAuth.instance.currentUser!.uid];
                // print(singleDoc);
                String resturant = singleDoc['subscribtionOwner'];
                // print(singleDoc);

                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('resturant')
                      .doc(resturant)
                      .get(),
                  builder: (context, resturantSnapshot) {
                    if (resturantSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      if (index == 0) {
                        return Center(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width / 2),
                          child: const CircularProgressIndicator(),
                        ));
                      }
                    }
                    if (resturantSnapshot.hasData) {
                      if (resturantSnapshot.data!.data() != null) {
                        final resturantInfo = resturantSnapshot.data!.data();
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
                            margin: const EdgeInsets.all(12),
                            // margin: EdgeInsets.all(12),
                            child: Material(
                              elevation: 20,
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                padding: const EdgeInsets.all(12),
                                // height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(width: 2)),
                                child: Row(
                                  children: [
                                    resturantInfo['imageUrl'] is String
                                        ? CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              resturantInfo['imageUrl'],
                                            ),
                                          )

                                        //  CircleAvatar(
                                        //     radius: 40,
                                        //     backgroundImage: NetworkImage(
                                        //       resturantInfo['imageUrl'],
                                        //     ),
                                        //   )
                                        : Container(),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'resturant name   '
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  resturantInfo['name'],
                                                  // softWrap: false,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      'current Balance   '
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    singleDoc['currentBalance'],
                                                    style: const TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    'subscription amoun'
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  singleDoc[
                                                      'subscriptionAmount'],
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
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

                      //if there is a data but it is null
                      return Container();
                    } else {
                      return const Center(
                        child: Text('unknown error'),
                      );
                    }

                    // print(resturant);
                    // print(snapshot.data!.data());
                  },
                );
              },
            );
          }
          if (subscriptionSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text('xon');
        },
      ),
    );
  }
}
