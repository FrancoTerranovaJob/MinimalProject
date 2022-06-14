import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
          alignment: Alignment.topRight,
          child: Image.asset('assets/spread_0.png')),
      Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/spread_1.png')),
      Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/spread_2.png'))
    ]);
  }
}