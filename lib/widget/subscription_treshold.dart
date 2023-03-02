import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

class SubscriptionTreshold extends StatelessWidget {
  final snap;
  const SubscriptionTreshold({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('subscription')
            .doc(snap['owner'])
            // .where('owner', isEqualTo: snap['owner'])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.data() != null) {
              final snapSubscription = snapshot.data!.data();
              final min = snapSubscription['minthreshold'];
              final max = snapSubscription['maxthreshold'];

              AppStateProvider.of(context)!.state.maxthreshold = max;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //min threshold
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: style.Style.SecondaryColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              min,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Minimum Threshold',
                              style: TextStyle(
                                  color: style.Style.resturantTagColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),

                    //max threshold
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: style.Style.SecondaryColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              max,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Maximum Threshold',
                              style: TextStyle(
                                  color: style.Style.resturantTagColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Container(
                child: Text('no data found'),
              );
            }
          } else {
            return Container(
              child: Text('having difficulties fetching data'),
            );
          }
        });
  }
}
