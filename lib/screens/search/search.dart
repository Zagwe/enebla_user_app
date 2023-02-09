import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../comment_and_rating.dart';
import '../home/resturant_home_page.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchResult = "none";
  FirebaseAuth _auth = FirebaseAuth.instance;

  // List<String> searchResult = [
  //   '130ETB - Ethiopian', 'shiro migib'
  // ];
  final searchController = TextEditingController();

  // final maxController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    print(searchResult);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          // color: Colors.black,
        ),
        title: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: TextField(
              controller: searchController,
              onChanged: (val) {
                setState(() {
                  searchResult = val;
                  // print(searchResult);
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search....',
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('resturant')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshots.data!.docs[index].data()
                  as Map<String, dynamic>;

                  if (searchResult.isEmpty) {
                    return ListTile(
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data['address'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("lib/assets/home.png"),
                      ),
                    );
                  }
                  if (data['name']
                      .toString()
                      .toLowerCase()
                      .startsWith(searchResult.toLowerCase())) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CommentAndRating()));
                      },
                      child: ListTile(
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['address'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("lib/assets/home.png"),
                        ),
                      ),
                    );
                  }
                  return Container();
                });
          }
      ),);
  }

}




































      // searchResult.isEmpty
      //     ? Center(
      //         child: Padding(
      //           padding: const EdgeInsets.fromLTRB(18, 120, 18, 18),
      //           child: Column(
      //             children: [
      //               Padding(
      //                 padding: EdgeInsets.fromLTRB(8, 18, 8, 8),
      //                 child: Icon(
      //                   Icons.search,
      //                   size: 100,
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.all(8.0),
      //                 child: Column(
      //                   children: [
      //                     Center(
      //                       child: Text(
      //                         'Please enter A Key word you want to search for.',
      //                         style: TextStyle(
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w600,
      //                             color: Color.fromARGB(133, 133, 133, 133)),
      //                       ),
      //                     ),
      //                     Center(
      //                       child: Text(
      //                         'SEARCH RESTULT WILL',
      //                         style: TextStyle(
      //                             fontSize: 24, fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     Center(
      //                       child: Text(
      //                         'APPEAR HERE ',
      //                         style: TextStyle(
      //                             fontSize: 24, fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     : GridView.builder(
      //         padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      //         itemCount: searchResult.length,
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //             crossAxisSpacing: 14.0,
      //             mainAxisSpacing: 3.0,
      //             mainAxisExtent: 220),
      //         itemBuilder: (context, index) {
      //           return Column(children: [
      //             Container(
      //               height: 160,
      //               decoration: BoxDecoration(
      //                 border: Border.all(width: 0),
      //                 borderRadius: BorderRadius.circular(15),
      //                 image: DecorationImage(
      //                     image: AssetImage("lib/assets/home.jpg"),
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //             Padding(
      //                 padding: EdgeInsets.fromLTRB(0, 10, 55, 0),
      //                 child: Text(searchResult[1],
      //                     style: TextStyle(
      //                       fontSize: 24,
      //                       color: Colors.black,
      //                       wordSpacing: 6,
      //                     ))),
      //             Padding(
      //                 padding: EdgeInsets.fromLTRB(0, 5, 75, 0),
      //                 child: Text(searchResult[0],
      //                     style: TextStyle(
      //                       fontSize: 13,
      //                       color: Color.fromRGBO(133, 133, 133, 0.8),
      //                       // wordSpacing: 4,
      //                 ))),
      //             ]);
      //         })