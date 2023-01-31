import 'package:flutter/material.dart';
import 'package:enebla_user_app/style.dart' as style;

class ResturantItem extends StatelessWidget {
  final String title;
  final String body;

  ResturantItem(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //resturant image section
        Container(
          height: 240,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.amber),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(),
          ),
        ),
        //resturant name
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size.zero, padding: EdgeInsets.zero),
          onPressed: () {},
          child: Text(
            'Resturant name',
            style: TextStyle(color: style.Style.primaryColor, fontSize: 20),
          ),
        ),

        //tag
        RichText(
            text: TextSpan(
                style: TextStyle(
                    color: style.Style.resturantTagColor, fontSize: 16),
                children: const [
              TextSpan(text: '\$\$'),
              TextSpan(text: ' \u2981 '),
              TextSpan(text: 'chicken'),
              TextSpan(text: ' \u2981 '),
              TextSpan(text: 'America'),
              TextSpan(text: ' \u2981  '),
              TextSpan(text: 'Deshi Food'),
            ])),

        SizedBox(
          height: 6,
        ),

        //rating and comment
        Row(
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
                  children: [
                    Icon(
                      Icons.comment,
                      size: 20,
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
        )
      ],
    );
  }
}
