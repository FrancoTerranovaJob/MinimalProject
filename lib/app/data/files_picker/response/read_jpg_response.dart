import 'package:equatable/equatable.dart';

class ReadJpgResponse extends Equatable {
  final String? jpg;

  const ReadJpgResponse({this.jpg});

  @override
  List<Object?> get props => [jpg];
}