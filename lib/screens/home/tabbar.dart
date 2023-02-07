import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart';

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
  late TabController _tabController;

  var menu;
  var foodlist;

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorWeight: 20,

          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),

          indicatorPadding: EdgeInsets.only(right: 20, top: 40),
          //labelPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          isScrollable: true,
          controller: _tabController,
          tabs: tabs,
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: List<Widget>.generate(widget.menuName.length, (int index) {
            // return ListView.builder(
            //   itemBuilder: (context, index) {
            //     final menu = widget.menuItem;
            //     final foods =
            //         widget.menuItem[widget.menuName[index]]['listOfFood'];

            //     return Container();
            //   },
            // );
            final foods = widget.menuItem[widget.menuName[index]]['listOfFood'];

            return ListView.builder(
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.0, 10), //(x,y)
                              blurRadius: 1.0,
                              blurStyle: BlurStyle.inner),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1)),
                    child: Center(
                        child: Text(
                      foods[index]['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  );
                });
          }),
        ))
      ],
    );
  }
}

Widget makeFoodList() {
  return ListView();
}


///working on tabbarview children
//  ListView.builder(
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
// // menuItem['menuname[index]']['listoffood'][index][name]
//                   // final menu = widget.menuItem;
//                   // final foods =
//                   // widget.menuItem[widget.menuName[index]]['listOfFood'];
//                   print('=-=-=-=-');

//                   // print(widget.menuItem[widget.menuName[index]]['listOfFood']
//                   //     [index]['name']);

//                   menu = widget.menuItem[widget.menuName[index]];
//                   foodlist =
//                       widget.menuItem[widget.menuName[index]]['listOfFood'];
//                   print(foodlist);
//                   // print(widget.menuName[index]);
//                   return Container(
//                     height: 70,
//                     margin: EdgeInsets.all(10),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(width: 1)),
//                     child: Center(child: Text(foodlist[index]['name'])),
//                   );
//                 }),