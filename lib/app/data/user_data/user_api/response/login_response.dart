import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String photo;
  final String phone;
  final dynamic facebookId;
  final int role;
  final int status;
  final int isNotification;
  final dynamic caption;
  final String tokenType;
  final String accessToken;

  const LoginResponse(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.photo,
      required this.phone,
      this.facebookId,
      required this.role,
      required this.status,
      required this.isNotification,
      this.caption,
      required this.tokenType,
      required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        photo: json['photo'],
        phone: json['phone'],
        role: json['role'],
        status: json['status'],
        isNotification: json['is_notification'],
        tokenType: json['token_type'],
        accessToken: json['access_token']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['photo'] = photo;
    data['phone'] = phone;
    data['facebook_id'] = facebookId;
    data['role'] = role;
    data['status'] = status;
    data['is_notification'] = isNotification;
    data['caption'] = caption;
    data['token_type'] = tokenType;
    data['access_token'] = accessToken;
    return data;
  }

  @override
  List<Object> get props => [
        id,
        firstname,
        lastname,
        email,
        photo,
        phone,
        facebookId,
        role,
        status,
        isNotification,
        caption,
        tokenType,
        accessToken,
      ];
}