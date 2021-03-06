import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api_impl.dart';
import 'package:minimal/app/data/files_picker/files_picker.dart';
import 'package:minimal/app/data/files_picker/files_picker_impl.dart';
import 'package:minimal/app/data/secure_storage/secure_storage.dart';
import 'package:minimal/app/data/secure_storage/secure_storage_impl.dart';

import 'package:minimal/app/data/user_data/user_api/user_api.dart';

import 'package:minimal/app/domain/client_domain/clients_repository/clients_repository.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';
import 'package:minimal/app/domain/user_domain/use_cases/user_use_cases.dart';
import 'package:minimal/app/domain/user_domain/user_repository/user_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/data/user_data/user_api/user_api_impl.dart';

import '../app/domain/client_domain/clients_repository/clients_repository_impl.dart';
import '../app/domain/user_domain/user_repository/user_repository_impl.dart';

final services = GetIt.instance;

void setupDI() {
  services
      .registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // http client
  services.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: 'https://agency-coda.uc.r.appspot.com',
      connectTimeout: 5000,
      sendTimeout: 5000))
    ..interceptors.add(PrettyDioLogger(requestHeader: true)));
  services.registerSingleton<SecureStorage>(SecureStorageImpl());
  services.registerLazySingleton<FilesPicker>(() => FilesPickerImpl());

  services.registerLazySingleton<ClientsApi>(() => ClientsApiImpl());
  services
      .registerLazySingleton<ClientsRepository>(() => ClientsRepositoryImpl());
  services.registerLazySingleton<UserApi>(() => UserApiImpl());

  services.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  services.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  services.registerLazySingleton<IsLoggedUseCase>(() => IsLoggedUseCase());
  services
      .registerLazySingleton<IsValidLoginUseCase>(() => IsValidLoginUseCase());

  services.registerLazySingleton<GetClientsUseCase>(() => GetClientsUseCase());
  services.registerLazySingleton<SearchClientsUseCase>(
      () => SearchClientsUseCase());
  services.registerLazySingleton<SearchClientPhotoUseCase>(
      () => SearchClientPhotoUseCase());
  services.registerLazySingleton<ValidateNewClientDataUseCase>(
      () => ValidateNewClientDataUseCase());
  services.registerLazySingleton<AddClientUseCase>(() => AddClientUseCase());
  services.registerLazySingleton<SaveEditedClientUseCase>(
      () => SaveEditedClientUseCase());
  services
      .registerLazySingleton<DeleteClientUseCase>(() => DeleteClientUseCase());
}