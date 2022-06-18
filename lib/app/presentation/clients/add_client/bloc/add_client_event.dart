part of 'add_client_bloc.dart';

abstract class AddClientEvent extends Equatable {
  const AddClientEvent();
}

class SearchClientPhotoEvent extends AddClientEvent {
  @override
  List<Object> get props => [];
}

class OnCreateNewUserEvent extends AddClientEvent {
  @override
  List<Object> get props => [];
}

class FirstNameChangedEvent extends AddClientEvent {
  final String firstname;

  const FirstNameChangedEvent(this.firstname);
  @override
  List<Object> get props => [firstname];
}

class LastNameChangedEvent extends AddClientEvent {
  final String lastname;

  const LastNameChangedEvent(this.lastname);
  @override
  List<Object> get props => [lastname];
}

class EmailChangedEvent extends AddClientEvent {
  final String email;

  const EmailChangedEvent(this.email);
  @override
  List<Object> get props => [email];
}