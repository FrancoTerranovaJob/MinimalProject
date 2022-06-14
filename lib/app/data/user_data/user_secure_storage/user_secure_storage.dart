import '../../../domain/user_domain/entities/user.dart';

abstract class UserSecureStorage {
  static const String userSessionKey = 'USER_SESSION_KEY';
  Future<User?> getSession();
  Future<bool> setSession(User user);
}