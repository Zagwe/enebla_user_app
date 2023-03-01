import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:enebla_user_app/screens/order/orderPreview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:flutter/rendering.dart';

import '../menu/tab_bar_listtile.dart';

class TopTabBarWidget extends StatefulWidget {
  final snap;
  final menuItem;
  final menuName;
  const TopTabBarWidget(
      {Key? key,
      required this.snap,
      required this.menuItem,
      required this.menuName})
      : super(key: key);

  @override
  State<TopTabBarWidget> createState() => _TopTabBarWidget();
}

class _TopTabBarWidget extends State<TopTabBarWidget>
    with SingleTickerProviderStateMixin {
  bool visibility = false;

  refresh(BuildContext context) {
    // if (AppStateProvider.of(context)!.state.orderFoodList['food']!.isEmpty) {
    //   setState(() {
    //     visibility = true;
    //   });
    //   print('empty');
    // } else {
    //   setState(() {
    //     visibility = false;
    //   });
    //   print('not empty');
    // }
    // if (visibility == false) {
    //   setState(() {
    //     visibility = true;
    //   });
    // } else {
    //   setState(() {
    //     visibility = false;
    //   });
    // }
  }

  late TabController _tabController;
  Color containerColor = Colors.white;

  getTabs() {
    for (var item in widget.menuName) {
      tabs.add(Tab(
        text: item,
      ));
    }
  }

  List<Tab> tabs = <Tab>[];

  @override
  void initState() {
    super.initState();

    getTabs();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  bool checkedvalue = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ValueNotifier show = ValueNotifier(
        AppStateProvider.of(context)?.state.orderFoodList['food']!.length);
    show.notifyListeners();
    return Stack(
      children: [
        Column(
          children: [
            TabBar(
              indicatorWeight: 20,

              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),

              indicatorPadding: const EdgeInsets.only(right: 20, top: 40),
              //labelPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              isScrollable: true,
              controller: _tabController,
              onTap: (value) {
                setState(() {
                  visibility = false;
                });
              },
              tabs: tabs,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children:
                  List<Widget>.generate(widget.menuName.length, (int index) {
                final foods =
                    widget.menuItem[widget.menuName[index]]['listOfFood'];
                // print(foods['image']);
                // print(foods[index]['image']);

                //LIST VIEW BUILDER START
                return ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      final name = foods[index]['name'];
                      final price = foods[index]['price'].toString();
                      // print(foods);

                      return ListViewTile(
                        image: foods[index]['image'],
                        notifyParent: refresh,
                        containerColor: containerColor,
                        name: name,
                        price: price,
                      );
                    });
              }),
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('subscriptionuser')
                        .doc(widget.snap['id'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.data() != null) {
                          if (snapshot.data!.data()![
                                  FirebaseAuth.instance.currentUser!.uid] ==
                              null) {
                            ///he hasen't subscribed
                            ///
                            ///subscribed button green
                            ///
                            ///add button gray

                            return buttonMaker(
                                context: context,
                                disabled: true,
                                icon: const Icon(
                                  Icons.add,
                                  size: 50,
                                ));
                          } else {
                            return buttonMaker(
                                context: context,
                                disabled: false,
                                icon: const Icon(
                                  Icons.add,
                                  size: 50,
                                ));
                          }
                        }
                      }

                      return buttonMaker(
                          context: context,
                          disabled: true,
                          icon: const Icon(
                            Icons.add,
                            size: 50,
                          ));
                    }),
              ),
            )
          ],
        ),
      ],
    );
    ;
  }

  //button maker function

  Widget buttonMaker(
      {required BuildContext context, required bool disabled, required icon}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled
            ? style.Style.SecondaryColor.withOpacity(.4)
            : style.Style.SecondaryColor,
      ),
      onPressed: disabled ? _disabledButtonHandler : _enableddButtonHandler,
      child: icon,
    );
  }

  _disabledButtonHandler() {
    ElegantNotification(
      width: MediaQuery.of(context).size.width,
      title: const Text("subscribe!!"),
      description: const Text("You Have subscribe in order to make an order"),
      icon: const Icon(
        Icons.cancel,
        color: Colors.red,
      ),
      toastDuration: Duration(seconds: 5),
      progressIndicatorColor: Colors.red,
    ).show(context);
  }

  _enableddButtonHandler() {
    if (AppStateProvider.of(context)!.state.orderFoodList['food']!.isNotEmpty) {
      AppStateProvider.of(context)
          ?.state
          .orderFoodList['resturantId']!
          .add(widget.snap['id']);

      ElegantNotification(
        width: MediaQuery.of(context).size.width,
        title: const Text("Success"),
        description: const Text("order has been added"),
        icon: const Icon(
          Icons.done,
          color: Colors.green,
        ),
        progressIndicatorColor: Colors.green,
      ).show(context);

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OrderPreview()));
      });
    } else {
      ElegantNotification(
        width: MediaQuery.of(context).size.width,
        title: const Text("order failed"),
        description: const Text("you have to select food to make an order"),
        icon: const Icon(
          Icons.done,
          color: Colors.red,
        ),
        progressIndicatorColor: Colors.red,
      ).show(context);
    }
  }
}
