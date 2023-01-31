import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
            title: 'Section 1',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use System Theme',
                leading: Icon(Icons.phone_android),
                switchValue: isSwitched,
                onToggle: (value) {
                },
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Section 2',
            tiles: [
              SettingsTile(
                title: 'Security',
                subtitle: 'Fingerprint',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {},
                ),
              ],
            ),
          ],
        ),
      );
    }
}


