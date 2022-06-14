import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minimal/app/data/secure_storage/secure_storage.dart';

import 'package:minimal/app/domain/user_domain/entities/user.dart';

import 'package:minimal/di/get_it.dart';

import 'exceptions/secure_storage_exceptions.dart';

class SecureStorageImpl extends SecureStorage {
  final storage = services.get<FlutterSecureStorage>();
  @override
  Future<User?> getSession() async {
    try {
      final user = await storage.read(key: SecureStorage.userSessionKey);

      if (user != null) {
        return User.fromJson(jsonDecode(user));
      }
      return null;
    } catch (e) {
      throw SessionRetrieveException(
          e, 'Could not retrieve user session from secure storage');
    }
  }

  @override
  Future<bool> setSession(User user) async {
    try {
      await storage.write(
          key: SecureStorage.userSessionKey, value: jsonEncode(user.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }
}