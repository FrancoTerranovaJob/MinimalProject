part of 'add_client_bloc.dart';

enum AddClientErrorType { invalidImage, none, unknown }

abstract class AddClientState extends Equatable {
  final Client newClient;
  final int validationStatus;
  final AddClientErrorType errorType;
  const AddClientState(
      {required this.newClient,
      required this.validationStatus,
      this.errorType = AddClientErrorType.none});

  @override
  List<Object> get props => [newClient, validationStatus, errorType];
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
      {required super.newClient,
      required super.validationStatus,
      super.errorType});
}

class AddingClientLoadingState extends AddClientState {
  const AddingClientLoadingState(
      {required super.newClient, required super.validationStatus});
}

class AddClientSuccessState extends AddClientState {
  const AddClientSuccessState(
      {required super.newClient, required super.validationStatus});
}

class AddClientErrorState extends AddClientState {
  const AddClientErrorState(
      {required super.newClient,
      required super.validationStatus,
      required super.errorType});
}