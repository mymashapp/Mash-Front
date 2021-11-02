import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FadeInImages extends StatefulWidget {
  @override
  _FadeInImagesState createState() => _FadeInImagesState();
}

class _FadeInImagesState extends State<FadeInImages> {
  int _currentIndex = 0;
  List<String> images = [
    "assets/login_screen_images/splash1.jpg",
    "assets/login_screen_images/splash2.jpg",
    "assets/login_screen_images/splash3.jpg",
    "assets/login_screen_images/splash4.jpg",
    "assets/login_screen_images/splash5.jpg",
    "assets/login_screen_images/splash6.jpg",
    "assets/login_screen_images/splash7.jpg"
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (timer) async {
      if (mounted) {
        setState(() {
          if (_currentIndex + 1 == images.length) {
            _currentIndex = 0;
          } else {
            _currentIndex = _currentIndex + 1;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 2400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          child: child,
          opacity: animation,
        );
      },
      child: Image.asset(
        images[_currentIndex],
        height: Get.height,
        width: Get.width,
        fit: BoxFit.cover,
        key: ValueKey<int>(_currentIndex),
      ),
    );
  }
}
