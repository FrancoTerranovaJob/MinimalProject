import 'package:minimal/app/domain/user_domain/entities/user.dart';

import '../entities/login.dart';

abstract class UserRepository {
  Future<bool> isLogged();
  Future<bool> login(Login login);
}