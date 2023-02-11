import 'package:enebla_user_app/screens/comment_and_rating.dart';
import 'package:enebla_user_app/screens/home/resturant_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ResturantItem extends StatelessWidget {
  final snap;
  ResturantItem({required this.snap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //resturant image section
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResturantHomePage(
                            snap: snap,
                          )));
            },
            child: Container(
              height: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "lib/assets/home.jpg",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          //resturant name
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
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: style.Style.resturantTagColor, fontSize: 16),
                  children: [
                TextSpan(text: '\$\$'),
                TextSpan(text: ' \u2981 '),
                TextSpan(text: 'chicken'),
                TextSpan(text: ' \u2981 '),
                TextSpan(text: snap['address']),
                TextSpan(text: ' \u2981  '),
                TextSpan(text: 'Deshi Food'),
              ])),

          SizedBox(
            height: 6,
          ),

          //rating and comment
          GestureDetector(
            onTap: () {
              print('=-=-=-=-=-=-=-=-=-');
              print(FirebaseAuth.instance.currentUser!.uid);
              print(snap);
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
            child: Row(
              children: [
                Row(
                  children: [
                    //rating
                    Row(
                      children: [
                        //rating value
                        Text('4.5'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: style.Style.SecondaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //rated people count
                        Text('200+ Rating'),
                      ],
                    ),
                    //separetor
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '\u2981',
                        style: TextStyle(
                            color: style.Style.resturantTagColor, fontSize: 16),
                      ),
                    ),

                    //comment
                    Row(
                      children: const [
                        Icon(
                          Icons.comment,
                          size: 20,
                          color: Color.fromARGB(255, 54, 48, 48),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('comment')
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
