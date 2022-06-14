import 'package:minimal/app/domain/user_domain/entities/login.dart';
import 'package:minimal/app/domain/user_domain/entities/user.dart';
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

class IsLoggedUseCase {
  final userRepository = services.get<UserRepository>();

  Future<bool> call() async {
    try {
      return await userRepository.isLogged();
    } catch (e) {
      rethrow;
    }
  }
}

class IsValidLoginUseCase {
  bool call(Login login) {
    var emailDomain = '';
    var emailUserName = '';
    if (login.email.contains('@')) {
      final emailSplit = login.email.split('@');
      emailUserName = emailSplit[0];
      emailDomain = emailSplit[1];
    }

    return emailUserName.isNotEmpty &&
        emailDomain.isNotEmpty &&
        login.password.isNotEmpty;
  }
}