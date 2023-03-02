import 'package:enebla_user_app/auth/login.dart';
import 'package:enebla_user_app/screens/account/balance.dart';
import 'package:enebla_user_app/screens/account/balance_page.dart';
import 'package:enebla_user_app/screens/account/changePassword.dart';
import 'package:enebla_user_app/screens/account/contucUs.dart';
import 'package:enebla_user_app/screens/account/editProfile.dart';
import 'package:enebla_user_app/screens/account/subscripion/subscription_list.dart';
import 'package:enebla_user_app/screens/order/orderPreview.dart';
import 'package:enebla_user_app/screens/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import '../../enebla_user_home.dart';
import '../order/order.dart';
import 'PrivacyPolicyScreen.dart';
import 'termsAndConditions.dart';
import '../subscription/balanceView.dart';
import 'aboutUs.dart';

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
              // SettingsTile(
              //   title: 'Home',
              //   subtitle: 'Go to Enebla Home',
              //   leading: Icon(Icons.home),
              //   onPressed: (BuildContext context) {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => EneblaHome()));
              //   },
              // ),
              SettingsTile(
                title: 'Balance',
                subtitle: 'Change your account information',
                leading: Icon(Icons.currency_exchange),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BalancePage()));
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
                          builder: (context) => BackupSettings()));
                },
              ),
              SettingsTile(
                title: 'Payment Method',
                subtitle: 'Add your Account',
                leading: Icon(Icons.payment),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentMethod()));
                },
              ),
              // SettingsTile(
              //   title: 'Order History',
              //   subtitle: 'View Order History',
              //   leading: Icon(Icons.fastfood),
              //   onPressed: (BuildContext context) {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => Order()));
              //   },
              // ),
              SettingsTile(
                title: 'subscription list',
                subtitle: 'View subscription list',
                leading: Icon(Icons.fastfood),
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubscriptionList()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
              ),
              SettingsTile(
                title: 'About Us',
                subtitle: 'information About Us',
                leading: Icon(Icons.info),
                onPressed: (BuildContext context) {
                  showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset("lib/assets/logo1.png",
                          height: 80, width: 80),
                      applicationName: 'About Enebla',
                      applicationVersion: 'Version 0.0.1',
                      applicationLegalese:
                          'Developed by Telet Software Solution',
                      children: <Widget>[
                        Text(
                            "Enebla and allows users to pay for their orders with a pre-paid subscription plan, which will allow restaurants to compete on price and quality."),
                        Text(
                            "It uses crowdsourced ratings from users' friends and family to make recommendations of restaurants")
                      ]);

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AboutUs()));
                },
              ),
              SettingsTile(
                title: 'Rules & Regulations',
                subtitle: 'information About Us',
                leading: Icon(Icons.balance),
                onPressed: (BuildContext context) {
                  showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset("lib/assets/logo1.png",
                          height: 80, width: 80),
                      applicationName: 'About Enebla',
                      applicationVersion: 'Version 0.0.1',
                      applicationLegalese:
                          'Developed by Telet Software Solution',
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                '1-The user and customer of the application must have either telebirr or bank account \n',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                '2-When setting a threshold, the customer is allowed to set any amount he or she prefers. For example, if the customer wants to set a minimum threshold of 0ETB or less, he or she can choose to do soThe customer will not be guaranteed that the user will be able to pay back any money they owe; however, we recommend setting a lower threshold of 0ETB.\n',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                '3-The user cannot unsubscribe until they have placed 15 consecutive orders. In the event that a user is in an exceptional situation and must unsubscribe, we will make them fill out a special form \n',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                '4-If a customer is registered, they must provide service for at least 6 months beforethey can request to cancel. \n',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                '5-The user and customer must be fill legal information about background \n',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ]);

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AboutUs()));
                },
              ),
              SettingsTile(
                title: 'Terms & Conditions',
                subtitle: 'Terms & Conditions to use the application',
                leading: Icon(Icons.warning),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                },
              ),
              SettingsTile(
                title: 'Privacy Policy',
                subtitle: 'PrivacyPolicyScreen to consider',
                leading: Icon(Icons.policy),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
                },
              ),
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.logout),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  //navigator
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
