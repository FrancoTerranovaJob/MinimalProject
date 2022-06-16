import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadProgress extends StatelessWidget {
  const LoadProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        child: Center(
          child: Lottie.asset(
            'assets/progress.json',
            width: 250,
            height: 200,
          ),
        ));
  }
}