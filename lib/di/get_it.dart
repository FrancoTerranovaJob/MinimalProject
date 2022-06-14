import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api_impl.dart';

import 'package:minimal/app/data/user_data/user_api/user_api.dart';
import 'package:minimal/app/domain/client_domain/clients_repository/clients_repository.dart';
import 'package:minimal/app/domain/user_domain/user_repository/user_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/data/user_data/user_api/user_api_impl.dart';
import '../app/data/user_data/user_secure_storage/user_secure_storage.dart';
import '../app/data/user_data/user_secure_storage/user_secure_storage_impl.dart';
import '../app/domain/client_domain/clients_repository/clients_repository_impl.dart';
import '../app/domain/user_domain/user_repository/user_repository_impl.dart';

final services = GetIt.instance;

void setup() {
  services
      .registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // http client
  services.registerSingleton<Dio>(Dio(BaseOptions(
    baseUrl: '',
  ))
    ..interceptors.add(PrettyDioLogger()));
  services.registerSingleton<UserSecureStorage>(UserSecureStorageImpl());
  services.registerLazySingleton<ClientsApi>(() => ClientsApiImpl());
  services
      .registerLazySingleton<ClientsRepository>(() => ClientsRepositoryImpl());
  services.registerLazySingleton<UserApi>(() => UserApiImpl());

  services.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}