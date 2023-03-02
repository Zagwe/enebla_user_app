import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

class SubscriptionTreshold extends StatelessWidget {
  Widget makeRow({required threshold, required value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'etb'.toUpperCase(),
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          threshold,
          style: TextStyle(
              color: style.Style.resturantTagColor,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        )
      ],
    );
  }

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
              return Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 3,
                )),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //min threshold
                    makeRow(threshold: 'Minimum threshold', value: min),
                    VerticalDivider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                    //max threshold

                    makeRow(threshold: 'Maximum threshold', value: max)
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
