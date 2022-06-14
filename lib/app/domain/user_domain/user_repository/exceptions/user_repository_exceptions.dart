import 'package:minimal/app/common/exceptions/domain_exception.dart';
import 'package:minimal/app/data/user_data/user_api/response/login_response.dart';

class LoginUserRepositoryException extends DomainException {
  LoginResponseFailed? failedLogin;

  LoginUserRepositoryException(super.error, super.message, {this.failedLogin});
}