import 'package:enebla_user_app/screens/account/accountSetting.dart';
import 'package:enebla_user_app/screens/home/homepage.dart';
import 'package:enebla_user_app/screens/order/order.dart';
import 'package:enebla_user_app/screens/order/orderPreview.dart';
import 'package:enebla_user_app/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

class EneblaHome extends StatefulWidget {
  const EneblaHome({super.key});

  @override
  State<EneblaHome> createState() => _EneblaHomeState();
}

class _EneblaHomeState extends State<EneblaHome> {
  int _currentIndex = 0;
  late PageController _pageController;

  int _selectedIndex = 0;

  ////
  static final List _widgetOptions = [
    const HomePage(),
    Search(),
    OrderPreview(),
    const AccountSetting(),
  ];

  @override
  void initState() {
    super.initState();
    // _pageController = PageController();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: style.Style.primaryColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: style.Style.navBarSecondaryColor,
              tabs: const [
                GButton(
                  icon: Icons.food_bank_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: 'Order',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
    );
  }
}
