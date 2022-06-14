import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimal/app/data/user_data/user_secure_storage/exceptions/secure_storage_exceptions.dart';
import 'package:minimal/app/data/user_data/user_secure_storage/user_secure_storage_impl.dart';
import 'package:minimal/di/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'secure_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  services.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  final storage =
      (services.get<FlutterSecureStorage>() as MockFlutterSecureStorage);
  final userStorage = UserSecureStorageImpl();

  test('getting exception when retrieve User', () async {
    when(storage.read(key: 'USER_SESSION_KEY'))
        .thenAnswer((realInvocation) async {
      final string = jsonEncode({
        "id": 1,
        "firstname": "empty",
        "lastname": "",
        "photo": "",
        "phone": "",
        "facebook_id": null,
        "role": 0,
        "created_at": "2022-06-10T23:18:20.000000Z",
        "updated_at": "2022-06-10T23:18:20.000000Z",
        "status": 0,
        "is_notification": 0,
        "caption": null,
        "token_type": "bearer",
        "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1g"
      });
      return string;
    });
    try {
      await userStorage.getSession();
    } catch (e) {
      expect(e, isInstanceOf<SessionRetrieveException>());
      log(e.toString());
    }
  });
}