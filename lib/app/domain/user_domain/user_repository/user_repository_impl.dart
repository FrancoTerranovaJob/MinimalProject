import 'package:minimal/app/common/exceptions/api_exception.dart';
import 'package:minimal/app/common/exceptions/secure_storage_exception.dart';
import 'package:minimal/app/data/user_data/user_api/exceptions/user_api_exceptions.dart';
import 'package:minimal/app/data/user_data/user_api/request/login_request.dart';
import 'package:minimal/app/data/user_data/user_api/response/login_response.dart';

import 'package:minimal/app/data/user_data/user_api/user_api.dart';
import 'package:minimal/app/domain/user_domain/entities/login.dart';
import 'package:minimal/app/domain/user_domain/user_repository/exceptions/user_repository_exceptions.dart';

import 'package:minimal/app/domain/user_domain/user_repository/user_repository.dart';

import '../../../../di/get_it.dart';
import '../../../data/user_data/user_secure_storage/user_secure_storage.dart';

import '../entities/user.dart';

class UserRepositoryImpl extends UserRepository {
  final secureStorage = services.get<UserSecureStorage>();
  final api = services.get<UserApi>();

  @override
  Future<bool> login(Login login) async {
    try {
      final response = await api
          .login(LoginRequest(email: login.email, password: login.password));
      if (response is LoginResponseSuccess) {
        final user = User(
            id: response.id,
            firstname: response.firstname,
            lastname: response.lastname,
            email: response.email,
            photo: response.photo,
            phone: response.phone,
            role: response.role,
            status: response.status,
            isNotification: response.isNotification,
            tokenType: response.tokenType,
            accessToken: response.accessToken);
        await _setSession(user);
        return true;
      }

      throw LoginUserRepositoryException(
        failedLogin: (response as LoginResponseFailed),
        response,
        'Bad credentials exception',
      );
    } on DioException catch (e) {
      throw LoginUserRepositoryException(e, 'Network Exception');
    } on ApiException catch (e) {
      throw LoginUserRepositoryException(e, 'User Api Exception');
    } catch (e) {
      if (e is LoginUserRepositoryException) {
        rethrow;
      }
      throw LoginUserRepositoryException(e, 'Log in user repository Exception');
    }
  }

  @override
  Future<bool> isLogged() async {
    try {
      final session = await secureStorage.getSession();
      return session != null;
    } on SecureStorageException catch (_) {
      rethrow;
    }
  }

  Future<bool> _setSession(User user) async {
    return await secureStorage.setSession(user);
  }
}