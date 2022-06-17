part of 'add_client_bloc.dart';

abstract class AddClientState extends Equatable {
  final Client newClient;
  final int validationStatus;
  const AddClientState(
      {required this.newClient, required this.validationStatus});

  @override
  List<Object> get props => [newClient, validationStatus];
}

class AddClientInitial extends AddClientState {
  const AddClientInitial()
      : super(
            newClient: const Client(
                id: -1,
                firstname: '',
                lastname: '',
                email: '',
                address: '',
                photo: '',
                caption: ''),
            validationStatus: 0);
}

class AddingClientState extends AddClientState {
  const AddingClientState(
      {required super.newClient, required super.validationStatus});
}

class AddingClientLoadingState extends AddClientState {
  const AddingClientLoadingState(
      {required super.newClient, required super.validationStatus});
}