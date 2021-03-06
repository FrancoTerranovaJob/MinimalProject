part of 'home_bloc.dart';

enum LoginStatus { logged, notLogged }

abstract class HomeState extends Equatable {
  final LoginStatus loginStatus;
  final User? session;
  const HomeState({required this.loginStatus, this.session});

  @override
  List<Object> get props => [loginStatus];
}

class InitialState extends HomeState {
  const InitialState({super.loginStatus = LoginStatus.notLogged});
}

class LoadingState extends HomeState {
  const LoadingState({super.loginStatus = LoginStatus.notLogged});
}

class AppStatus extends HomeState {
  const AppStatus({required super.loginStatus});
}

class ErrorState extends HomeState {
  const ErrorState({required super.loginStatus});
}