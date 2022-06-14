import 'package:dio/dio.dart';
import 'package:minimal/app/data/user_data/user_api/request/login_request.dart';
import 'package:minimal/app/data/user_data/user_api/response/login_response.dart';
import 'package:minimal/app/data/user_data/user_api/user_api.dart';
import 'package:minimal/di/get_it.dart';

import 'exceptions/user_api_exceptions.dart';

class UserApiImpl extends UserApi {
  static const String userPath = '/mia-auth';
  final http = services.get<Dio>();
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final response =
          await http.post('$userPath/login', data: loginRequest.toJson());
      final Map<String, dynamic> loginResponseJson = response.data;
      if (loginResponseJson['success']) {
        return LoginResponseSuccess.fromJson(loginResponseJson);
      }
      return LoginResponseFailed.fromJson(loginResponseJson);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw UserLoginException(e, 'Failed to login');
    }
  }

  DioException _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.response:
        return DioException(error, 'Dio response exception');

      case DioErrorType.connectTimeout:
        return DioException(error, 'Dio connection timeout exception');

      case DioErrorType.sendTimeout:
        return DioException(error, 'Dio connection send timeout exception');
      case DioErrorType.receiveTimeout:
        return DioException(error, 'Dio connection receive timeout exception');

      case DioErrorType.cancel:
        return DioException(error, 'Dio cancel exception');

      case DioErrorType.other:
        return DioException(error, 'Dio unknown exception');
    }
  }
}