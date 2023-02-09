import 'package:enebla_user_app/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

import '../../widget/tab_bar_listtile.dart';

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
    return ValueListenableBuilder(
        valueListenable: show,
        builder: (context, value, child) {
          if (value != 0) {
            visibility = true;
          }
          print('-=-==-=-');
          print(value);

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
                    children: List<Widget>.generate(widget.menuName.length,
                        (int index) {
                      // return ListView.builder(
                      //   itemBuilder: (context, index) {
                      //     final menu = widget.menuItem;
                      //     final foods =
                      //         widget.menuItem[widget.menuName[index]]['listOfFood'];

                      //     return Container();
                      //   },
                      // );
                      final foods =
                          widget.menuItem[widget.menuName[index]]['listOfFood'];

                      //LIST VIEW BUILDER START
                      return ListView.builder(
                          itemCount: foods.length,
                          itemBuilder: (context, index) {
                            final name = foods[index]['name'];
                            final price = foods[index]['price'].toString();
                            return ListViewTile(
                              notifyParent: refresh,
                              containerColor: containerColor,
                              name: name,
                              price: price,
                            );
                          });
                    }),
                  )),
                  // FloatingActionButton(
                  //   onPressed: () {},
                  //   child: Icon(Icons.add),
                  // )
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: style.Style.SecondaryColor,
                        ),
                        onPressed: () {
                          AppStateProvider.of(context)
                              ?.state
                              .orderFoodList['resturantId']!
                              .add(widget.snap['owner']);
                        },
                        child: const Icon(
                          Icons.add,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
