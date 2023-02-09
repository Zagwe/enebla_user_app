import 'package:enebla_user_app/widget/resturant_card.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:enebla_user_app/provider/dumy_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/dumy_provider.dart';

class HomePageSlider extends StatefulWidget {
  HomePageSlider({super.key});

  @override
  State<HomePageSlider> createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  static PageController controller =
      PageController(keepPage: true, viewportFraction: .9);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: DummyProvider.imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: .95,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: DummyProvider.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
