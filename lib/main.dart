import 'package:flutter/material.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api.dart';

import 'package:minimal/app/minimal_app.dart';
import 'package:minimal/di/get_it.dart';

void main() async {
  setupDI();
  WidgetsFlutterBinding.ensureInitialized();

  final result = await services.get<ClientsApi>().deleteClient(924);

  runApp(const MinimalApp());
}