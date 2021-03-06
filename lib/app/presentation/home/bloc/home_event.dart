part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CheckUserSessionEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class UserLoggedEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}