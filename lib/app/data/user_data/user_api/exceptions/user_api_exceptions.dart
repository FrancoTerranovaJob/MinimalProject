import 'package:minimal/app/common/exceptions/api_exception.dart';

import '../../../../common/exceptions/http_exception.dart';

class DioException extends HttpException {
  DioException(super.error, super.message);
}

class UserLoginException extends ApiException {
  UserLoginException(super.error, super.message);
}