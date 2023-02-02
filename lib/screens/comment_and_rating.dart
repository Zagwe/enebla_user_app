import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

class CommentAndRating extends StatefulWidget {
  const CommentAndRating({super.key});

  @override
  State<CommentAndRating> createState() => _CommentAndRatingState();
}

class _CommentAndRatingState extends State<CommentAndRating> {
  final double ratingValue = 4.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //rating
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$ratingValue Rating',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    // SizedBox(
                    //   width: 20,
                    //   child: ListView.builder(
                    //       physics: NeverScrollableScrollPhysics(),
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: ratingValue.round(),
                    //       itemBuilder: (context, index) {
                    //         return Icon(
                    //           Icons.star,
                    //           color: style.Style.SecondaryColor,
                    //           size: 20,
                    //         );
                    //       }),
                    // )
                  ],
                ),
                Text('200+', style: Theme.of(context).textTheme.headlineMedium)
              ],
            ),
          ),
          //commnet
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.black,
                            )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'username',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width * .7,
                            child: Text(
                              'some random text made by some random ass user and there is always some bug bla bla bla blaand  andotehr bla bla bla lsfjls ajklfdsk jldk sldkj fsd lsdkjf lkjsdlfkj lsdkjf sldjflsdjf klsjdf fdsl kjlfjdssldkj sdlfj lkj fldskjflkjsdlf kjsdlkfjlsdkjf sldfjlsdkjf jkdsfjlsdkf jsld kjf',
                            ),
                          )
                        ],
                      )
                    ]),
              );
            }),
          )
        ],
      ),
    );
  }
}
