import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

import '../../../provider/dumy_provider.dart';

class ResturantPageUpperSlider extends StatelessWidget {
  ResturantPageUpperSlider({super.key});
  PageController _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //the sliding image
        SizedBox(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
              pageSnapping: true,
              controller: _pageController,
              itemCount: DummyProvider.imgList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  //we need to have a defualt picture in case the image won't load
                  child: Image.asset(
                    DummyProvider.imgList[index],
                    fit: BoxFit.cover,
                  ),
                );
              }),
        ),
        //upper back and share buttons
        Positioned(
            top: 40,
            left: 20,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )),
        Positioned(
            right: 20,
            top: 40,
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            )),
        //the idicator
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: DummyProvider.imgList.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: style.Style.primaryColor,
                type: WormType.normal,
                // strokeWidth: 5,
              ),
            ),
          ),
        )
      ],
    );
  }
}
