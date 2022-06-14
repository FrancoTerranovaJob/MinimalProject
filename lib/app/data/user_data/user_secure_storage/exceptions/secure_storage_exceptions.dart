import 'package:minimal/app/common/exceptions/secure_storage_exception.dart';

class SessionRetrieveException extends SecureStorageException {
  SessionRetrieveException(super.error, super.message);
}