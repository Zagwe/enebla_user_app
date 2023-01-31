import 'package:flutter/material.dart';

class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);

  List<String> searchResult =[
    'ferfer','shiro'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(

        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                // suffixIcon: IconButton(
                //   icon: const Icon(
                //       Icons.clear,
                //     color: Colors.black,
                //   ),
                //   onPressed: () {
                //
                //   },
                // ),
                  hintText: 'Search ....',
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none

              ),
            ),
          ),

        ),
      ),
      body: searchResult!.length == 0 ?
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 200, 18, 18),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 18, 8, 8),
                    child: Icon(
                      Icons.search,
                      size: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'please type in a key word',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
          :GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0
          ),
          itemBuilder: (context, index)
            {
              return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(searchResult[1]),
            );
          }
        ),
      );
  }
}


