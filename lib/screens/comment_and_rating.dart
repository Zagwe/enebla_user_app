import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:fluttertoast/fluttertoast.dart';

class CommentAndRating extends StatefulWidget {
  //should expent the id of resturant being commented

  String commentedby;
  String commentedto;
  CommentAndRating(
      {super.key, required this.commentedby, required this.commentedto});

  @override
  State<CommentAndRating> createState() => _CommentAndRatingState();
}

class _CommentAndRatingState extends State<CommentAndRating> {
  final double ratingValue = 4.6;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of(context)!.blocProvider.commentBloc;
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

          ///COMMENT ADDING SECIONT
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: commentController,
                        autofocus: true,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            focusColor: style.Style.primaryColor,
                            hoverColor: style.Style.primaryColor,
                            label: Text('add comment'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you need to write a comment';
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 2)),
                      child: IconButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              String res = await bloc.commentService
                                  .postUserCommentToDatabase(
                                      commentedby: widget.commentedby,
                                      commentedto: widget.commentedto,
                                      comment: commentController.text);

                              Fluttertoast.showToast(msg: res);
                            }
                          },
                          icon: Icon(Icons.send)))
                ],
              ),
            ),
          ),

          //commnet
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .doc(widget.commentedto)
                  .snapshots(),
              builder: (context, commentsnapshot) {
                if (commentsnapshot.hasData) {
                  if (commentsnapshot.data!.data() != null) {
                    ////working on allowing a single user to make multiple commetns
                    ///due to time constraintes a user can only make one comment for now
                    // int length = 0;
                    // List comments = [];
                    List keys = commentsnapshot.data!.data()!.keys.toList();

                    // for (var key in keys) {
                    //   length = (length +
                    //       commentsnapshot.data!
                    //           .data()![key]['comment']
                    //           .length) as int;
                    // }

                    return ListView.builder(
                        itemCount: keys.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: _firestore
                                  .collection('users')
                                  .doc(keys[index])
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  String username =
                                      '${snapshot.data!.data()!['firstname']} ${snapshot.data!.data()!['lastname']}';

                                  String comment = commentsnapshot.data!
                                      .data()![keys[index]]['comment'];
                                  String? imageUrl;

                                  if (snapshot.data!.data()!['photoUrl'] !=
                                      null) {
                                    imageUrl =
                                        snapshot.data!.data()!['photoUrl'];
                                  }
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    // padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),

                                            ///the image of user profile
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: imageUrl == null
                                                  ? Image.asset(
                                                      'lib/assets/profile image.png',
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      imageUrl,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                username,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              LimitedBox(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .7,
                                                child: Text(comment),
                                              )
                                            ],
                                          )
                                        ]),
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              });
                        });
                  } else {
                    return Center(
                      child: Text('there is no comment yet'),
                    );
                  }
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
