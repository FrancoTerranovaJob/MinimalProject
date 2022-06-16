import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String address;
  final String photo;
  final String caption;

  const Client(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.address,
      required this.photo,
      required this.caption});

  @override
  List<Object> get props => [
        id,
        firstname,
        lastname,
        email,
        address,
        photo,
        caption,
      ];
}