import 'package:minimal/app/domain/user_domain/entities/login.dart';
import 'package:minimal/app/domain/user_domain/user_repository/user_repository.dart';
import 'package:minimal/di/get_it.dart';

class LoginUseCase {
  final userRepository = services.get<UserRepository>();

  Future<bool> call(Login login) async {
    try {
      return await userRepository.login(login);
    } catch (e) {
      rethrow;
    }
  }
}