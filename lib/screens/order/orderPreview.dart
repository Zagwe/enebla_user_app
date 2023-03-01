import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/enebla_user_home.dart';
import 'package:enebla_user_app/screens/order/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

import '../../bloc/state.dart';
import '../../service/balance_services.dart';
import '../../service/subscription_service.dart';
import '../subscription/balanceView.dart';

class OrderPreview extends StatefulWidget {
  const OrderPreview({Key? key}) : super(key: key);

  @override
  State<OrderPreview> createState() => _OrderPreviewState();
}

class _OrderPreviewState extends State<OrderPreview> {
  var totalBalance;
  var balance;
  var treshHold;
  BalanceService balanceService = new BalanceService();
  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of(context)?.blocProvider.orderBloc;
    var orderTotal = bloc!.orderService.getOrderTotal(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Center(
          child: Text('Preview Orders',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              )),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: AppStateProvider.of(context)!
                            .state
                            .orderFoodList['resturantId']!
                            .isNotEmpty
                        ? AppStateProvider.of(context)!
                            .state
                            .orderFoodList['food']!
                            .length
                        : 1,
                    itemBuilder: (context, index) {
                      List? foodlist = AppStateProvider.of(context)
                          ?.state
                          .orderFoodList['food'];
                      List? priceList = AppStateProvider.of(context)
                          ?.state
                          .orderFoodList['price'];

                      return AppStateProvider.of(context)!
                              .state
                              .orderFoodList['resturantId']!
                              .isNotEmpty
                          ? Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                padding: const EdgeInsets.all(30),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  // color: Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [const Icon(Icons.delete)],
                                ),
                              ),
                              onDismissed: (direction) {
                                bloc.orderService.removeFoodFromOrderList(
                                    context: context,
                                    foodName: foodlist[index]);

                                /// this has to be remvoed if possible i am re rendering the entire
                                /// page just to change the numbers of the food list
                                ///
                                /// we can replace the numbers with image maybe
                                setState(() {});
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  padding: const EdgeInsets.all(30),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: style.Style.primaryColor,
                                    // color: Colors.red,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        foodlist![index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        priceList![index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(
                              child: Text(
                                  'you need to click the add button after selecting food item from menu',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.red)),
                            );
                    })),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2.4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Text(
                          (bloc.orderService.getOrderTotal(context)).toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'VAT',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Text(
                          '15%',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Text(
                          (bloc.orderService.getOrderTotal(context) * 1.15)
                              .toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EneblaHome()));
                          },
                          child: Text(
                            'Add more items',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: style.Style.primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EneblaHome()));
                          },
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
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
                            var snapBalance =[AppStateProvider.of(context)!
                                .state
                                .orderFoodList['resturantId']!
                                .first,FirebaseAuth.instance.currentUser!.uid,];

                            var resturant = await FirebaseFirestore.instance
                                .collection('subscriptionuser')
                                .doc(AppStateProvider.of(context)!
                                    .state
                                    .orderFoodList['resturantId']!
                                    .first)
                                .get()
                                .then((value) => value.data());

                            var subscription = await FirebaseFirestore.instance
                                .collection('subscription')
                                .doc(AppStateProvider.of(context)!
                                .state
                                .orderFoodList['resturantId']!
                                .first)
                                .get()
                                .then((value) => value.data());
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% resturantId threshhold");

                            print(AppStateProvider.of(context)!
                                .state
                                .orderFoodList['resturantId']!
                                .first);
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% resturantId threshhold");
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subscription threshhold");

                            print(subscription);
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subscription threshhold");
                            treshHold = subscription!['minthreshold'];
                              print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% threshhold");

                              print(treshHold);
                              print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% threshhold");
                            balance = resturant![FirebaseAuth
                                .instance.currentUser!.uid]["currentBalance"];

                            var currentTotalBalance = int.parse(balance) - int.parse(treshHold);
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% currentTotalBalance");

                            print(currentTotalBalance);
                            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% currentTotalBalance");

                            if (currentTotalBalance >
                                bloc.orderService.getOrderTotal(context)) {
                              totalBalance = currentTotalBalance -
                                  bloc.orderService.getOrderTotal(context);
                              balanceService.setCurrentBalance(
                                  totalBalance: totalBalance.toString(),
                                  subscribtionOwner: resturant[FirebaseAuth
                                      .instance
                                      .currentUser!
                                      .uid]["subscribtionOwner"],
                                  subscribtionUser:
                                      FirebaseAuth.instance.currentUser!.uid);

                              if (AppStateProvider.of(context)!
                                  .state
                                  .orderFoodList['food']!
                                  .isNotEmpty) {
                                await bloc.orderService
                                    .addOrderToDatabase(context: context);
                              }
                            } else {
                              ElegantNotification(
                                title: const Text("Error"),
                                description: Text(
                                    "your Current balance is ${balance} Please order a food that cost less or update your subscription"),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                progressIndicatorColor: Colors.red,
                              ).show(context);
                            }
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => BalanceView(
                                  resturantId: AppStateProvider.of(context)!
                                      .state
                                      .orderFoodList['resturantId']!
                                      .first,
                                  userId: FirebaseAuth.instance.currentUser!.uid,
                                  currentBalance: balance,)));
                            setState(() {
                              AppStateProvider.of(context)!
                                  .state
                                  .orderFoodList['food']!
                                  .clear();

                              AppStateProvider.of(context)!
                                  .state
                                  .orderFoodList['price']!
                                  .clear();
                            });
                          },
                          child: const Text(
                            'Continue To Order',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
