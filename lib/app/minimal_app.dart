import 'package:flutter/material.dart';
import 'package:minimal/app/presentation/home/home_page.dart';
import 'package:minimal/theme/minimal_app_theme.dart';

class MinimalApp extends StatelessWidget {
  const MinimalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MinimalApp',
      theme: MinimalAppTheme.getTheme(context),
      home: const HomePage(),
    );
  }
}