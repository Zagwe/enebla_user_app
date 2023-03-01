// import 'package:enebla_customer/screens/Subscription/tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/service/balance_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:enebla_user_app/theme/style.dart' as style;

import '../../bloc/state.dart';
import '../../service/subscription_service.dart';
import '../chapapayment/chapa_payment initializer.dart';
class BalanceView extends StatefulWidget {
  var resturantId;
  var userId;

  BalanceView({super.key,  required this.resturantId, required this.userId});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  var amountController = TextEditingController();
  var args;
  String message = "";
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (ModalRoute.of(context)?.settings.arguments != null) {
          args = ModalRoute.of(context)?.settings.arguments;
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after payment ");
          message = args['message'];
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(message);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(args['transactionReference']);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% transactionReference ");
          print(args['paidAmount']);
        }
      });
    });
    super.initState();
  }

  Widget title(String title) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: style.Style.primaryColor,
                fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
          child: Divider(
            color: style.Style.primaryColor,
            thickness: 2,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List keys = [];
    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
            title: Text(
              'Balance Details',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 25, color: style.Style.primaryColor),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SafeArea(
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // ResturantPageUpperSlider(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      title('Current Balance'),
                      ////resturant information section
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('subscriptionuser')
                            .doc(widget.resturantId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          var balance = snapshot!.data![widget.userId]["currentBalance"];
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey, //New
                                  blurRadius: 25.0,
                                  // offset: Offset(0, -10)
                              )
                            ], color: style.Style.primaryColor),
                            padding: const EdgeInsets.all(12),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Current Balance".toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),

                                  Text(
                                    "${balance} ETB",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      title('Update Balance'),

                      ///list of subscribed user
                      Form(
                        key: _formkey,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Enter TopUp Amount',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color:Colors.black ),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: TextFormField(
                                          controller: amountController,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.edit),
                                              hintText: 'TopUp Amount',
                                              hintStyle: TextStyle(fontSize: 20),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1),
                                                  borderRadius: BorderRadius.circular(20)
                                              )),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter Correct TopUp Amount';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 160,
                    ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(12)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: style.Style.primaryColor,

                            ),
                            onPressed: () async {
                              var snap =[widget.resturantId,widget.userId];
                              AppStateProvider.of(context)?.state.snap = snap as Map<String, dynamic>;
                              await Chapa.paymentParameters(
                                context: context, // context
                                publicKey: 'CHASECK_TEST-FnTXa03f7dXyGVn0HCyfZFvHgT8j1XJX',
                                currency: 'ETB',
                                amount: amountController.text,
                                email: 'xyz@gmail.com',
                                firstName: 'firstname',
                                lastName: 'lastname',
                                txRef: '34TXTHHgb',
                                title: 'title',
                                desc: 'desc',
                                namedRouteFallBack: '/fallbackBalance',
                                // fall back route name
                              );

                              if(args['message'] == 'paymentSuccessful' ){
                                //logic
                                BalanceService().setCurrentBalance(
                                    totalBalance: amountController.text,
                                    subscribtionOwner: widget.resturantId,
                                    subscribtionUser: widget.userId
                                );

                              }else{
                                ElegantNotification(
                                  title: const Text("Error"),
                                  description:
                                  const Text(" Payment failed"),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  progressIndicatorColor: Colors.red,
                                ).show(context);
                              }


                            },
                              child: const Text(
                            'TopUp',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
