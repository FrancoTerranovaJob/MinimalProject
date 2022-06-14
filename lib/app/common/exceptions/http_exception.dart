abstract class HttpException implements Exception {
  final Object error;
  final String message;

  @override
  String toString() => '$message \n ${error.toString()}';

  HttpException(this.error, this.message);
}