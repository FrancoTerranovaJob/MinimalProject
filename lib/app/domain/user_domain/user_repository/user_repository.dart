import '../entities/login.dart';

abstract class UserRepository {
  Future<bool> isLogged();
  Future<bool> login(Login login);
}