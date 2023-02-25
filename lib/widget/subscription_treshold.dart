import 'package:cloud_firestore/cloud_firestore.dart';
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
            .where('owner', isEqualTo: snap['owner'])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final snapSubscription = snapshot.data!.docs[0].data();
          final min = snapSubscription['minthreshold'];
          final max = snapSubscription['maxthreshold'];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: Colors.black,
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
          );
        });
  }
}
