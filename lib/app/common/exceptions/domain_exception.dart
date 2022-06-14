abstract class DomainException implements Exception {
  final Object error;
  final String message;

  @override
  String toString() => '$message \n ${error.toString()}';

  DomainException(this.error, this.message);
}