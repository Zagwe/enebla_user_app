import 'package:enebla_user_app/enebla_user_home.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          'Balance status',
          style: TextStyle(color: style.Style.primaryColor),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.grey[200],
            child: SizedBox(
              height: 100.0,
              child: InkWell(
                splashColor: Colors.green,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EneblaHome()));
                },
                child: Row(children: const <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text('fikir ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23)),
                    subtitle: Text('restaurant'),
                    trailing: Text('123'),
                  ))
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
