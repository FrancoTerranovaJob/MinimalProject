import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/data/clients_data/clients_api/exceptions/client_api_exceptions.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';
import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';
import 'package:minimal/di/get_it.dart';

part 'add_client_event.dart';
part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final validateClientUseCase = services.get<ValidateNewClientDataUseCase>();
  final searchPhotoUseCase = services.get<SearchClientPhotoUseCase>();
  final addClientUseCase = services.get<AddClientUseCase>();
  AddClientBloc() : super(const AddClientInitial()) {
    on<SearchClientPhotoEvent>(_searchClientPhotoEvent);
    on<FirstNameChangedEvent>(_firstNameChangedEvent);

    on<LastNameChangedEvent>(_lastNameChangedEvent);

    on<EmailChangedEvent>(_emailChangedEvent);

    on<OnCreateNewUserEvent>(_onCreateNewUserEvent);
  }

  void _searchClientPhotoEvent(
      SearchClientPhotoEvent event, Emitter<AddClientState> emit) async {
    final clientWithPhoto = await searchPhotoUseCase.call(state.newClient);
    emit(AddingClientState(
        newClient: clientWithPhoto, validationStatus: state.validationStatus));
  }

  void _firstNameChangedEvent(
      FirstNameChangedEvent event, Emitter<AddClientState> emit) {
    emit(AddingClientState(
        newClient: Client(
            id: state.newClient.id,
            firstname: event.firstname,
            lastname: state.newClient.lastname,
            email: state.newClient.email,
            address: state.newClient.address,
            photo: state.newClient.photo,
            caption: state.newClient.caption),
        validationStatus: state.validationStatus));
  }

  void _lastNameChangedEvent(
      LastNameChangedEvent event, Emitter<AddClientState> emit) {
    emit(AddingClientState(
        newClient: Client(
            id: state.newClient.id,
            firstname: state.newClient.firstname,
            lastname: event.lastname,
            email: state.newClient.email,
            address: state.newClient.address,
            photo: state.newClient.photo,
            caption: state.newClient.caption),
        validationStatus: state.validationStatus));
  }

  void _emailChangedEvent(
      EmailChangedEvent event, Emitter<AddClientState> emit) {
    emit(AddingClientState(
        newClient: Client(
            id: state.newClient.id,
            firstname: state.newClient.firstname,
            lastname: state.newClient.lastname,
            email: event.email,
            address: state.newClient.address,
            photo: state.newClient.photo,
            caption: state.newClient.caption),
        validationStatus: state.validationStatus));
  }

  void _onCreateNewUserEvent(
      OnCreateNewUserEvent event, Emitter<AddClientState> emit) async {
    final isValidClient = validateClientUseCase.call(state.newClient);
    if (isValidClient == 1) {
      emit(AddingClientLoadingState(
          newClient: state.newClient,
          validationStatus: state.validationStatus));
      await addClientUseCase.call(state.newClient);
    } else {
      emit(AddingClientState(
          newClient: Client(
              id: state.newClient.id,
              firstname: state.newClient.firstname,
              lastname: state.newClient.lastname,
              email: state.newClient.email,
              address: state.newClient.address,
              photo: state.newClient.photo,
              caption: state.newClient.caption),
          validationStatus: isValidClient));
    }
  }
}