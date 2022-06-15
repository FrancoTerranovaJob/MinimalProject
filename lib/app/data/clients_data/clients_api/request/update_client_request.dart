import 'package:equatable/equatable.dart';

class UpdateClientRequest extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String address;
  final String photo;
  final String caption;

  UpdateClientRequest(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.address,
      required this.photo,
      required this.caption});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['address'] = address;
    data['photo'] = photo;
    data['caption'] = caption;
    return data;
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
      ];
}