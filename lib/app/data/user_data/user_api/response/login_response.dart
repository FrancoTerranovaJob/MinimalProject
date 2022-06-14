import 'package:equatable/equatable.dart';

abstract class LoginResponse {}

class LoginResponseSuccess extends Equatable implements LoginResponse {
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

  const LoginResponseSuccess(
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

  factory LoginResponseSuccess.fromJson(Map<String, dynamic> json) {
    final data = json['response'];
    return LoginResponseSuccess(
        id: data['id'],
        firstname: data['firstname'],
        lastname: data['lastname'],
        email: data['email'],
        photo: data['photo'],
        phone: data['phone'],
        role: data['role'],
        status: data['status'],
        isNotification: data['is_notification'],
        tokenType: data['token_type'],
        accessToken: data['access_token']);
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

class LoginResponseFailed extends Equatable implements LoginResponse {
  final int errorNumber;
  final String message;

  const LoginResponseFailed(this.errorNumber, this.message);

  factory LoginResponseFailed.fromJson(Map<String, dynamic> json) {
    final data = json['error'];
    return LoginResponseFailed(
      data['code'],
      data['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = errorNumber;
    data['message'] = message;

    return data;
  }

  @override
  List<Object> get props => [errorNumber, message];
}