part of 'edit_client_bloc.dart';

abstract class EditClientEvent extends Equatable {
  const EditClientEvent();
}

class SearchClientPhotoEvent extends EditClientEvent {
  @override
  List<Object> get props => [];
}

class OnSaveEditEvent extends EditClientEvent {
  @override
  List<Object> get props => [];
}

class FirstNameChangedEvent extends EditClientEvent {
  final String firstname;

  FirstNameChangedEvent(this.firstname);
  @override
  List<Object> get props => [firstname];
}

class LastNameChangedEvent extends EditClientEvent {
  final String lastname;

  LastNameChangedEvent(this.lastname);
  @override
  List<Object> get props => [lastname];
}

class EmailChangedEvent extends EditClientEvent {
  final String email;

  EmailChangedEvent(this.email);
  @override
  List<Object> get props => [email];
}