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

  FirstNameChangedEvent(this.firstname);
  @override
  List<Object> get props => [firstname];
}

class LastNameChangedEvent extends AddClientEvent {
  final String lastname;

  LastNameChangedEvent(this.lastname);
  @override
  List<Object> get props => [lastname];
}

class EmailChangedEvent extends AddClientEvent {
  final String email;

  EmailChangedEvent(this.email);
  @override
  List<Object> get props => [email];
}