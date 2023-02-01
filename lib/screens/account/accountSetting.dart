import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Setting'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Account Setting',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Profile Setting',
                subtitle: 'Change your account information',
                leading: Icon(Icons.phone_android),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Change Password',
                subtitle: 'Change your account Password',
                leading: Icon(Icons.phone_android),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Payment Method',
                subtitle: 'Add your Account',
                leading: Icon(Icons.phone_android),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Location',
                subtitle: 'Add or Remove Location',
                leading: Icon(Icons.phone_android),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'More',
            tiles: [
              SettingsTile(
                title: 'Contact Us',
                subtitle: 'Send us a direct email',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              ],
            ),
          ],
        ),
      );
    }
}


