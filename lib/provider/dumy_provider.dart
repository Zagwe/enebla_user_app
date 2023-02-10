import 'package:flutter/material.dart';

class DummyProvider {
  static List<String> imgList = [
    "lib/assets/home.jpg",
    "lib/assets/enebla.jpg",
    "lib/assets/home.jpg",
    "lib/assets/enebla.jpg",
    "lib/assets/home.jpg",
    ];
  static final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();
}
