import 'package:minimal/app/common/exceptions/api_exception.dart';
import 'package:minimal/app/common/exceptions/http_exception.dart';

class DioException extends HttpException {
  DioException(super.error, super.message);
}

class GetClientException extends ApiException {
  GetClientException(super.error, super.message);
}

class DeleteClientException extends ApiException {
  DeleteClientException(super.error, super.message);
}

class UpdateClientException extends ApiException {
  UpdateClientException(super.error, super.message);
}

class AddClientException extends ApiException {
  AddClientException(super.error, super.message);
}