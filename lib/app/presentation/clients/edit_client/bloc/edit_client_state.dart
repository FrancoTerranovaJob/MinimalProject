part of 'edit_client_bloc.dart';

enum EditClientErrorType { invalidImage, none, unknown }

abstract class EditClientState extends Equatable {
  final Client client;
  final int validationStatus;
  final EditClientErrorType errorType;
  const EditClientState(
      {required this.client,
      required this.validationStatus,
      this.errorType = EditClientErrorType.none});

  @override
  List<Object> get props => [client, validationStatus, errorType];
}

class EditClientInitial extends EditClientState {
  const EditClientInitial({required super.client}) : super(validationStatus: 0);
}

class EditingClientState extends EditClientState {
  const EditingClientState(
      {required super.client,
      required super.validationStatus,
      super.errorType});
}

class EditClientLoadingState extends EditClientState {
  const EditClientLoadingState(
      {required super.client, required super.validationStatus});
}

class EditClientSuccessState extends EditClientState {
  const EditClientSuccessState(
      {required super.client, required super.validationStatus});
}

class EditClientErrorState extends EditClientState {
  const EditClientErrorState(
      {required super.client,
      required super.validationStatus,
      required super.errorType});
}