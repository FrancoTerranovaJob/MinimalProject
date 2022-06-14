import 'package:minimal/app/common/exceptions/api_exception.dart';
import 'package:minimal/app/common/exceptions/secure_storage_exception.dart';
import 'package:minimal/app/data/user_data/user_api/exceptions/user_api_exceptions.dart';
import 'package:minimal/app/data/user_data/user_api/request/login_request.dart';
import 'package:minimal/app/data/user_data/user_api/user_api.dart';
import 'package:minimal/app/domain/user_domain/user_repository/exceptions/user_repository_exceptions.dart';
import 'package:minimal/app/domain/user_domain/user_repository/user_repository.dart';

import '../../../../di/get_it.dart';
import '../../../data/user_data/user_secure_storage/user_secure_storage.dart';
import '../entities/login.dart';
import '../entities/user.dart';

class UserRepositoryImpl extends UserRepository {
  final secureStorage = services.get<UserSecureStorage>();
  final api = services.get<UserApi>();
  @override
  Future<bool> login(Login login) async {
    try {
      final response = await api
          .login(LoginRequest(email: login.email, password: login.password));
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
    } on DioException catch (e) {
      rethrow;
    } on ApiException catch (e) {
      rethrow;
    } catch (e) {
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