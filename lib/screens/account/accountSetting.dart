import 'package:enebla_user_app/screens/account/changePassword.dart';
import 'package:enebla_user_app/screens/account/contucUs.dart';
import 'package:enebla_user_app/screens/account/editProfile.dart';
import 'package:enebla_user_app/screens/order/orderPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:enebla_user_app/style.dart' as style;
import '../../enebla_home.dart';
import '../order/order.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          'Account Setting',
          style: TextStyle(color: style.Style.primaryColor),
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Account Setting',
            tiles: [
              SettingsTile(
                title: 'Home',
                subtitle: 'Go to Enebla Home',
                leading: Icon(Icons.home),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EneblaHome()));
                },
              ),
              SettingsTile(
                title: 'Profile Setting',
                subtitle: 'Change your account information',
                leading: Icon(Icons.manage_accounts),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
              ),
              SettingsTile(
                title: 'Change Password',
                subtitle: 'Change your account Password',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
              ),
              SettingsTile(
                title: 'Payment Method',
                subtitle: 'Add your Account',
                leading: Icon(Icons.payment),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Order History',
                subtitle: 'View Order History',
                leading: Icon(Icons.fastfood),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Order()));
                },
              ),
              // SettingsTile(
              //   title: 'Location',
              //   subtitle: 'Add or Remove Location',
              //   leading: Icon(Icons.location_on),
              //   onPressed: (BuildContext context) {},
              // ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'More',
            tiles: [
              SettingsTile(
                title: 'Contact Us',
                subtitle: 'Send us a direct email',
                leading: Icon(Icons.email),
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUs()));
                },
              ),
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.logout),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
