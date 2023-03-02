import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/screens/search/search.dart';
import 'package:enebla_user_app/screens/home/widget/homepage_slider.dart';
import 'package:enebla_user_app/screens/home/widget/resturant_card.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import '../../auth/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enebla',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: style.Style.primaryColor),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => OnBording()));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
              ),
            )
          ]),

      ////experimentaing on home page scroll bar
      ///still have alots of work to do on the scroll bar

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HomePageSlider(),
            Container(
              padding: const EdgeInsets.all(15),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('resturant')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    var snap;

                    if (snapshot.data != null) {
                      snap = snapshot.data!.docs;
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          final resturant = snap[index].data();

                          return ResturantItem(
                            snap: resturant,
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
