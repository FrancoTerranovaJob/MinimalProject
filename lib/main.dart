import 'package:flutter/material.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/create_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/post_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/update_client_request.dart';
import 'package:minimal/app/minimal_app.dart';
import 'package:minimal/di/get_it.dart';

void main() async {
  setupDI();

  final result = await services.get<ClientsApi>().deleteClient(762);

  runApp(const MinimalApp());
}