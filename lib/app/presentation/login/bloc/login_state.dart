part of 'login_bloc.dart';

enum LoginErrorType { none, account, password, network, unknown }

abstract class LoginState extends Equatable {
  final Login login;
  final bool enableButton;
  final bool showPassword;
  final bool showEmail;
  final LoginErrorType loginErrorType;

  const LoginState(
      {required this.login,
      required this.enableButton,
      required this.showEmail,
      required this.showPassword,
      this.loginErrorType = LoginErrorType.none});

  @override
  List<Object> get props => [
        login,
        enableButton,
        showPassword,
        showEmail,
        loginErrorType,
      ];
}

class LoginInitial extends LoginState {
  const LoginInitial()
      : super(
            login: const Login(email: '', password: ''),
            enableButton: false,
            showPassword: false,
            showEmail: true);
}

class AddingLoginCredentialsState extends LoginState {
  const AddingLoginCredentialsState(
      {required super.login,
      required super.enableButton,
      required super.showEmail,
      required super.showPassword});
}

class LoginErrorState extends LoginState {
  const LoginErrorState(
      {required super.login,
      required super.enableButton,
      required super.showEmail,
      required super.showPassword,
      super.loginErrorType});
}

class LoginLoadingstate extends LoginState {
  const LoginLoadingstate(
      {required super.login,
      required super.enableButton,
      required super.showEmail,
      required super.showPassword});
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState(
      {required super.login,
      required super.enableButton,
      required super.showEmail,
      required super.showPassword});
}