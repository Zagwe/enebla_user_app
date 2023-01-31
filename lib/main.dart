import 'package:enebla_user_app/search/search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EneblaUser(
    title: 'enebla user app',
  ));
}

class EneblaUser extends StatelessWidget {
  String title;
  EneblaUser({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EneblaHome(),
    );
  }
}

class EneblaHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
       home: Scaffold(
         appBar: AppBar(
           backgroundColor: Color.fromARGB(255, 17, 66, 204),
           title: Text('Enebla'),
           actions: [
             IconButton(onPressed: (){
               Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>
                           Search()));
              }, icon: const Icon(Icons.search))
           ],
         ),


       )
   );
  }
}
