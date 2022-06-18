import 'package:flutter/material.dart';
import 'package:minimal/app/minimal_app.dart';
import 'package:minimal/di/get_it.dart';

void main() async {
  setupDI();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MinimalApp());
}