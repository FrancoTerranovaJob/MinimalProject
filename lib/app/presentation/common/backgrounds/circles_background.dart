import 'package:flutter/material.dart';

class CirclesBackground extends StatelessWidget {
  const CirclesBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
          alignment: Alignment.topRight,
          child: Image.asset('assets/circle_0.png')),
      Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/circle_1.png')),
      Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/circle_2.png'))
    ]);
  }
}