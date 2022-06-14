import 'package:minimal/app/data/user_data/user_api/request/login_request.dart';
import 'package:minimal/app/data/user_data/user_api/response/login_response.dart';

abstract class UserApi {
  Future<LoginResponse> login(LoginRequest loginRequest);
}