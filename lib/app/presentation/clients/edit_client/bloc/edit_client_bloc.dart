import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/clients_repository/exceptions/client_repository_exceptions.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';
import 'package:minimal/di/get_it.dart';

part 'edit_client_event.dart';
part 'edit_client_state.dart';

class EditClientBloc extends Bloc<EditClientEvent, EditClientState> {
  final validateClientUseCase = services.get<ValidateNewClientDataUseCase>();
  final searchPhotoUseCase = services.get<SearchClientPhotoUseCase>();
  final saveEditedClientUseCase = services.get<SaveEditedClientUseCase>();
  EditClientBloc(EditClientState initialState) : super(initialState) {
    on<SearchClientPhotoEvent>(_searchClientPhotoEvent);
    on<FirstNameChangedEvent>(_firstNameChangedEvent);

    on<LastNameChangedEvent>(_lastNameChangedEvent);

    on<EmailChangedEvent>(_emailChangedEvent);

    on<OnSaveEditEvent>(_onSaveEditEvent);
  }

  void _searchClientPhotoEvent(
      SearchClientPhotoEvent event, Emitter<EditClientState> emit) async {
    final clientWithPhoto = await searchPhotoUseCase.call(state.client);
    emit(EditingClientState(
        client: clientWithPhoto, validationStatus: state.validationStatus));
  }

  void _firstNameChangedEvent(
      FirstNameChangedEvent event, Emitter<EditClientState> emit) {
    emit(EditingClientState(
        client: Client(
            id: state.client.id,
            firstname: event.firstname,
            lastname: state.client.lastname,
            email: state.client.email,
            address: state.client.address,
            photo: state.client.photo,
            caption: state.client.caption),
        validationStatus: state.validationStatus));
  }

  void _lastNameChangedEvent(
      LastNameChangedEvent event, Emitter<EditClientState> emit) {
    emit(EditingClientState(
        client: Client(
            id: state.client.id,
            firstname: state.client.firstname,
            lastname: event.lastname,
            email: state.client.email,
            address: state.client.address,
            photo: state.client.photo,
            caption: state.client.caption),
        validationStatus: state.validationStatus));
  }

  void _emailChangedEvent(
      EmailChangedEvent event, Emitter<EditClientState> emit) {
    emit(EditingClientState(
        client: Client(
            id: state.client.id,
            firstname: state.client.firstname,
            lastname: state.client.lastname,
            email: event.email,
            address: state.client.address,
            photo: state.client.photo,
            caption: state.client.caption),
        validationStatus: state.validationStatus));
  }

  void _onSaveEditEvent(
      OnSaveEditEvent event, Emitter<EditClientState> emit) async {
    final isValidClient = validateClientUseCase.call(state.client);
    if (isValidClient == 1) {
      emit(EditClientLoadingState(
          client: state.client, validationStatus: isValidClient));
      try {
        await saveEditedClientUseCase.call(state.client);

        emit(EditClientSuccessState(
            client: state.client, validationStatus: state.validationStatus));
      } on EditClientRepositoryException catch (e) {
        final errorType = _handleEditClient(e);
        emit(EditClientErrorState(
            client: state.client,
            validationStatus: state.validationStatus,
            errorType: errorType));
      }
    } else {
      emit(EditClientErrorState(
          client: state.client,
          errorType: state.errorType,
          validationStatus: isValidClient));
    }
  }

  EditClientErrorType _handleEditClient(EditClientRepositoryException e) {
    if (e.editClientFailed != null) {
      if (e.editClientFailed!.errorNumber == -2) {
        return EditClientErrorType.invalidImage;
      }
    }
    return EditClientErrorType.unknown;
  }
}