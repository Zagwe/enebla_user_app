import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String title;
  final String body;

  PostItem(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 200,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.amber),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(),
      ),
    );
  }
}
