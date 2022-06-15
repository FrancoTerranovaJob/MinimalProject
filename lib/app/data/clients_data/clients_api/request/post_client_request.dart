import 'package:equatable/equatable.dart';

class PostClientRequest extends Equatable {
  final int pageNumber;
  final int limit;

  const PostClientRequest({this.pageNumber = 0, this.limit = 5});

  Map<String, dynamic> toJson() {
    return {'limit': limit};
  }

  @override
  List<Object> get props => [pageNumber, limit];
}