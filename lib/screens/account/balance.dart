import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/enebla_user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../subscription/balanceView.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          'Balance status',
          style: TextStyle(color: style.Style.primaryColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('resturant')
            .snapshots(),
        builder: (context, snapshots) {
          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: ( context, index) {
              var data = snapshots.data!.docs[index].data()as Map<String, dynamic>;
              return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('subscriptionuser')
                      .doc(data['owner'])
                      .get(),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return GestureDetector(

                      onTap: () {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                BalanceView(resturantId: data['owner'],
                                  userId: FirebaseAuth.instance.currentUser!
                                      .uid,)));
                      },
                      child: ListTile(
                        // style: ListTileStyle.list,
                        title: Text(
                          data['name'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['address'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("lib/assets/home.png"),
                        ),
                        trailing: Text(
                            "${futureSnapshot!.data!.data()![FirebaseAuth
                                .instance.currentUser!
                                .uid]["currentBalance"]}ETB"),
                      ),
                    );
                  }
                }
              );
              //   Card(
              //   color: Colors.grey[200],
              //   child: SizedBox(
              //     height: 100.0,
              //     child: InkWell(
              //       splashColor: Colors.green,
              //       onTap: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) => EneblaHome()));
              //       },
              //       child: Row(children: const <Widget>[
              //         Expanded(
              //             child: ListTile(
              //               title: Text(data['name'],
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold, fontSize: 23)),
              //               subtitle: Text('restaurant'),
              //               trailing: Text('123'),
              //         ))
              //       ]),
              //     ),
              //   ),
              // );
            },
          );
        }
      ),
    );
  }
}
