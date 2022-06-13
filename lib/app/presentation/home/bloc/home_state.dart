part of 'home_bloc.dart';

enum LoginStatus { logged, notLogged }

abstract class HomeState extends Equatable {
  final LoginStatus loginStatus;

  const HomeState({required this.loginStatus});

  @override
  List<Object> get props => [loginStatus];
}

class InitialState extends HomeState {
  const InitialState({super.loginStatus = LoginStatus.notLogged});
}

class LoadingState extends HomeState {
  const LoadingState({required super.loginStatus});
}

class AppStatus extends HomeState {
  const AppStatus({required super.loginStatus});
}

class ErrorState extends HomeState {
  const ErrorState({required super.loginStatus});
}