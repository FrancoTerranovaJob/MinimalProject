part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  const EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  const PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class LoginButtonPressedEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class ShowEmailEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class ShowPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}