import 'package:enebla_user_app/screens/comment_and_rating.dart';
import 'package:enebla_user_app/screens/home/resturant_home_page.dart';
import 'package:enebla_user_app/screens/home/widget/resturant_information.dart';
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
    // if (snap['imageUrl'] is String) {
    //   print(snap['imageUrl']);
    // }
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
                child: snap['imageUrl'] != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FadeInImage(
                            placeholder: AssetImage('lib/assets/enebla.jpg'),
                            image: NetworkImage(snap['imageUrl'])),
                      )
                    //   Image.network(
                    //   snap['imageUrl'],
                    //   fit: BoxFit.fill,
                    //   width: MediaQuery.of(context).size.width,
                    // )
                    : Image.asset('lib/assets/enebla.jpg'),
              ),
            ),
          ),
          ResturantInformation(snap: snap)
          //resturant name
        ],
      ),
    );
  }
}
