import 'package:flutter/material.dart';

class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);

  List<String> searchResult =[
    '130ETB - Ethiopian','shiro migib'
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
                suffixIcon: IconButton(
                  icon: const Icon(
                      Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {

                  },
                ),
                  hintText: 'Search....',
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
              padding: const EdgeInsets.fromLTRB(18, 120, 18, 18),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 18, 8, 8),
                    child: Icon(
                      Icons.search,
                      size: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Please enter A Key word you want to search for.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            color: Color.fromARGB(133, 133, 133, 133)
                          ),
                        ),
                        Text(
                          'SEARCH RESTULT WILL APPEAR HERE ',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          :GridView.builder(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14.0,
              mainAxisSpacing: 3.0,
              mainAxisExtent: 240
          ),
          itemBuilder: (context, index)
            {
              return Column(
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0),
                          borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("lib/assets/home.jpg"),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 45, 0),
                        child: Text(
                            searchResult[1],
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              wordSpacing: 6,
                            )
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 50, 5),
                        child: Text(
                            searchResult[0],
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(133, 133, 133, 0.8),
                              // wordSpacing: 4,
                            )
                        )
                    ),
                  ]
              );
          }
        ),
      );
  }
}


