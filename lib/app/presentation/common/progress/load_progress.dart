import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadProgress extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;
  const LoadProgress(
      {Key? key, this.width = 250, this.height = 200, this.opacity = 0.7})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(opacity),
        child: Center(
          child: Lottie.asset(
            'assets/progress.json',
            width: 250,
            height: 200,
          ),
        ));
  }
}