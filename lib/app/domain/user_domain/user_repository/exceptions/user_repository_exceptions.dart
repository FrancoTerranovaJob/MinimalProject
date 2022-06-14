import 'package:minimal/app/common/exceptions/domain_exception.dart';

class LoginUserRepositoryException extends DomainException {
  LoginUserRepositoryException(super.error, super.message);
}