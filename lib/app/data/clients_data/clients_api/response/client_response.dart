import 'package:equatable/equatable.dart';

class ClientResponse extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String address;
  final String photo;
  final String caption;
  final String createdAt;
  final String updatedAt;
  final int deleted;

  const ClientResponse(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.address,
      required this.photo,
      required this.caption,
      required this.createdAt,
      required this.updatedAt,
      required this.deleted});

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        address: json['address'],
        photo: json['photo'],
        caption: json['caption'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deleted: 0);
  }

  @override
  List<Object> get props => [
        id,
        firstname,
        lastname,
        email,
        address,
        photo,
        caption,
        createdAt,
        updatedAt,
        deleted,
      ];
}