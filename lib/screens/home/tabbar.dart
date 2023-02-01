import 'package:flutter/material.dart';
import 'package:enebla_user_app/style.dart';

class TopTabBarWidget extends StatefulWidget {
  const TopTabBarWidget({Key? key}) : super(key: key);

  @override
  State<TopTabBarWidget> createState() => _TopTabBarWidget();
}

class _TopTabBarWidget extends State<TopTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Tab> tabs = <Tab>[
    const Tab(text: 'yetsom'),
    const Tab(text: 'yefitsek'),
    const Tab(text: 'fast food'),
    const Tab(
      text: 'erteb',
    ),
    const Tab(
      text: 'special',
    ),
  ];

  @override
  void initState() {
    super.initState();
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
          children: [],
        ))
      ],
    );
  }
}
