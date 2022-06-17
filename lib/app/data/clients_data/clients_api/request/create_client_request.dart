import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateClientRequest extends Equatable {
  final String firstname;
  final String lastname;
  final String email;
  final String address;
  final String photo;
  final String caption;

  const CreateClientRequest(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.address,
      required this.photo,
      required this.caption});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'address': address,
      'photo': photo.isNotEmpty ? base64Encode(photo.codeUnits) : photo,
      'caption': caption,
    };
  }

  @override
  List<Object> get props => [
        firstname,
        lastname,
        email,
        address,
        photo,
        caption,
      ];
}