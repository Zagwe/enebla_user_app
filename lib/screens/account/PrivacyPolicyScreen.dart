import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy'),
        ),
        body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Privacy Policy',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    Text(
    'Telet Software Solution built the Enebla Subscription based online food ordering mobile application app as a Commercial app. This SERVICE is provided by Telet Software Solution and is intended for use as is.',
    style: TextStyle(fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.',
    style: TextStyle(fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.',
    style: TextStyle(fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'Information Collection and Use',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16),
    Text(
    'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to payment detail, personal detail . The information that we request will be retained by us and used as described in this privacy policy.',
    style: TextStyle(fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'The app does use third-party services that may collect information used to identify you.',
    style: TextStyle(fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'Link to the privacy policy of third-party service providers used by the app',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16),
    TextButton(
    child: Text(
    'Google Play Services Privacy Policy',
    style: TextStyle(color: Colors.blue, fontSize: 16),
    ),
    onPressed: () {},
    ),
    TextButton(
    child: Text(
    'Google Analytics for Firebase Privacy Policy',
    style: TextStyle(color: Colors.blue, fontSize: 16),
    ),
    onPressed: () {},
    ),
    TextButton(
    child: Text(
    'Firebase Crashlytics Privacy Policy',
    style: TextStyle(color: Colors.blue, fontSize: 16),
    ),
    onPressed: () {},
    ),
    SizedBox(height: 16),
    Text(
    'Log Data',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16),
    Text(
    'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
    style: TextStyle(fontSize: 16),
    )
    ]
    )
    ));


  }
}