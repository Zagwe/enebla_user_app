import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

import '../../service/subscription_service.dart';

import '../chapapayment/chapa_payment initializer.dart';

class SubscriptionInfromation extends StatelessWidget {
  final snap;

  var args;
  // var payedAmount;
  SubscriptionInfromation({super.key, required this.snap,required this.args});

  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        //subscription amount
        Expanded(
          child: SizedBox(
            height: 40,
            width: 180,
            child: TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.edit),
                  hintText: 'Subscription Amount',
                  hintStyle: const TextStyle(fontSize: 10),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('subscriptionuser')
                .doc(snap['owner'])
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data!.data());
                if (snapshot.data!.data() != null) {
                  if (snapshot.data!
                          .data()![FirebaseAuth.instance.currentUser!.uid] ==
                      null) {
                    return buttonMaker(context);
                    //user hasent subscribed so show the clickeble button
                  } else {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // padding: const EdgeInsets.only(left: 13, right: 13),
                            backgroundColor:
                                style.Style.SecondaryColor.withOpacity(.3)),
                        onPressed: () {
                          // you have already subscribed
                          ElegantNotification(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .1,
                            title: const Text("subscribed"),
                            description:
                                const Text("you have already subscribed."),
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            progressIndicatorColor: Colors.red,
                          ).show(context);
                        },
                        child: Text(
                          'subscribed'.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ));

                    ///user has subscribed to this resturant so button shouldn't be clickable
                  }
                } else {
                  return buttonMaker(context);
                }
              }
              return ElevatedButton(
                onPressed: () {},
                child: Row(children: [Icon(Icons.error), Text('connecting')]),
              );
            }),

        //subscription Button
      ],
    );
  }

  Widget buttonMaker(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: style.Style.SecondaryColor),
        onPressed: () async {
          // print(amountController);

          if (amountController.text.isEmpty) {
            ElegantNotification(
              width: MediaQuery.of(context).size.width,
              title: const Text("Error"),
              description: Text(
                  " Please Enter Subscription Amount More Than ${AppStateProvider.of(context)!.state.maxthreshold} "),
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              progressIndicatorColor: Colors.red,
            ).show(context);
          }

          if (int.parse(amountController.text) < 1000) {
            ElegantNotification(
              title: const Text("Error"),
              description:
                  const Text(" The Subscription Amount must be More Than 1000"),
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              progressIndicatorColor: Colors.red,
            ).show(context);
          } else {
            AppStateProvider.of(context)?.state.snap = snap;
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-------AppStateProvider-------args");
            print(AppStateProvider.of(context)?.state.snap);
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-------AppStateProvider-------args");
         await Chapa.paymentParameters(
              context: context, // context
              publicKey: 'CHASECK_TEST-jmyHK17FPhLvjPDNRfNIAPODsfLKZd9Y',
              currency: 'ETB',
              amount: amountController.text,
              email: 'xyz@gmail.com',
              firstName: 'firstname',
              lastName: 'lastname',
              txRef: '34TXTHHgb',
              title: 'title',
              desc: 'desc',
              namedRouteFallBack: '/fallback',
            );

            AppStateProvider.of(context)!.state.snap = snap;

            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-------AppStateProvider-------args");
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-------AppStateProvider-------args");
            print(args);
             // //
            //  if(args['message'] == 'paymentSuccessful' ){
            //    await SubscriptionService().addSubscription(
            //       subscriptionAmount: amountController.text,
            //       subscriptionstatus: 'true',
            //       subscribedUser: FirebaseAuth.instance.currentUser!.uid,
            //       subscribtionOwner: snap['owner'],
            //       currentBalance: amountController.text
            //   );
            // }else{
            //   ElegantNotification(
            //     title: const Text("Error"),
            //     description:
            //     const Text(" Payment failed"),
            //     icon: const Icon(
            //       Icons.close,
            //       color: Colors.red,
            //     ),
            //     progressIndicatorColor: Colors.red,
            //   ).show(context);
            // }
            //

            ElegantNotification(
              title: const Text("Success"),
              description:
                  const Text("You Have Been Added to Subscription plan."),
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
              progressIndicatorColor: Colors.green,
            ).show(context);
          }
        },
        child: Text(
          'Subscribe'.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ));
  }
}
