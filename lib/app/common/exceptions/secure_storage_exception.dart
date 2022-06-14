abstract class SecureStorageException implements Exception {
  final Object error;
  final String message;

  @override
  String toString() => '$message \n ${error.toString()}';
  SecureStorageException(this.error, this.message);
}