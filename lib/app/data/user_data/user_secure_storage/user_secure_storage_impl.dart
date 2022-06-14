import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minimal/app/data/user_data/secure_storage/exceptions/secure_storage_exceptions.dart';
import 'package:minimal/app/data/user_data/secure_storage/user_secure_storage.dart';
import 'package:minimal/di/get_it.dart';

import '../../../domain/user_domain/entities/user.dart';

class UserSecureStorageImpl extends UserSecureStorage {
  final storage = services.get<FlutterSecureStorage>();
  @override
  Future<User?> getSession() async {
    try {
      final user = await storage.read(key: UserSecureStorage.userSessionKey);

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
          key: UserSecureStorage.userSessionKey,
          value: jsonEncode(user.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }
}