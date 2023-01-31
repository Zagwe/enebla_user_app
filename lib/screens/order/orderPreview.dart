import 'package:flutter/material.dart';
class OrderPreview extends StatelessWidget {
  const OrderPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            elevation: 0,
              leading: BackButton(
              color: Colors.black,
          ),
            title: Center(
                child: Text(
                  'Preview Orders',
                    style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    )
                ),
            ),
        ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 50,
                itemBuilder: (context, index){
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Ethiopia',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '140ETB',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  )
                  );
                }),
          ),
          // Container(
          //   child: Column(
          //     children: [
          //       // Row(
          //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       //   children: const <Widget>[
          //       //     Text(
          //       //       'UPCOMING ORDERS',
          //       //       style: TextStyle(
          //       //           fontSize: 18,
          //       //           fontWeight: FontWeight.w800,
          //       //           color: Colors.black54
          //       //       ),
          //       //     ),
          //       //     Text(
          //       //       'View History',
          //       //       textAlign: TextAlign.end,
          //       //       style: TextStyle(
          //       //           fontSize: 14,
          //       //           fontWeight: FontWeight.w800,
          //       //           color: Colors.black
          //       //       ),
          //       //     ),
          //       //   ],
          //       // ),
          //     ],
          //   )
          // ),
        ],
      ),
    );
  }
}
