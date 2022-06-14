import 'package:minimal/app/domain/user_domain/entities/user.dart';

abstract class SecureStorage {
  static const String userSessionKey = 'USER_SESSION_KEY';
  Future<User?> getSession();
  Future<bool> setSession(User user);
}