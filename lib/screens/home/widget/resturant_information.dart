import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:flutter_launcher_icons/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../comment_and_rating.dart';
import '../resturant_home_page.dart';

class ResturantInformation extends StatelessWidget {
  final snap;
  const ResturantInformation({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size.zero, padding: EdgeInsets.zero),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResturantHomePage(
                          snap: snap,
                        )));
          },
          child: Text(
            snap['name'],
            style: TextStyle(color: style.Style.primaryColor, fontSize: 20),
          ),
        ),

        //tag
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: style.Style.resturantTagColor, fontSize: 16),
                    children: [
                  const TextSpan(text: 'ETB'),
                  const TextSpan(text: ' \u2981 '),
                  const TextSpan(text: 'chicken'),
                  const TextSpan(text: ' \u2981 '),
                  TextSpan(text: snap['address']),
                  const TextSpan(text: ' \u2981  '),
                  const TextSpan(text: 'Deshi Food'),
                ])),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                // print('=-=-=-=-=-=-=-=-=-');
                // print(FirebaseAuth.instance.currentUser!.uid);
                // print(snap);
                showBarModalBottomSheet(
                  expand: false,
                  context: context,
                  bounce: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CommentAndRating(
                      commentedby: FirebaseAuth.instance.currentUser!.uid,
                      commentedto: snap['owner']),
                );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CommentAndRating()));
              },
              child: Container(
                width: 120,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Row(
                  children: [
                    Row(
                      children: [
                        // Text(
                        //   '\u2981',
                        //   style: TextStyle(
                        //       color: style.Style.resturantTagColor,
                        //       fontSize: 16),
                        // ),
                        Icon(
                          Icons.comment,
                          size: 20,
                          color: style.Style.SecondaryColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'comment'.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                        //comment
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),

        const SizedBox(
          height: 6,
        ),

        //rating and comment
      ],
    );
  }
}
