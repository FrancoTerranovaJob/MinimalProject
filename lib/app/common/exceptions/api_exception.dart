abstract class ApiException implements Exception {
  final Object error;
  final String message;

  @override
  String toString() => '$message \n ${error.toString()}';

  ApiException(this.error, this.message);
}