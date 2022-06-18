import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';

import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';

import 'package:minimal/di/get_it.dart';

part 'client_list_event.dart';
part 'client_list_state.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  final getClientsUseCase = services.get<GetClientsUseCase>();
  final deleteClientUseCase = services.get<DeleteClientUseCase>();
  ClientListBloc(ClientListState initialState) : super(initialState) {
    on<AddCachedImage>(_addCachedImage);
    on<GetClientsEvent>(_getClientsEvent);
    on<SearchClientEvent>(_searchClientEvent);
    on<RefreshClientListEvent>(_refreshClientListEvent);
    on<RefreshClientEvent>(_refreshClientEvent);
    on<DeleteClientEvent>(_deleteClientEvent);
  }

  void _addCachedImage(AddCachedImage event, Emitter<ClientListState> emit) {
    final images = <int, Uint8List>{};
    images.addAll(state.cachedClientImages);
    images[event.clientId] = event.image;
    emit(ClientsDataState(
      clients: state.clients,
      cachedClientImages: images,
    ));
  }

  void _getClientsEvent(
      GetClientsEvent event, Emitter<ClientListState> emit) async {
    if (state is ClientListInitial) {
      emit(ClientsLoadingState(
          clients: state.clients,
          cachedClientImages: state.cachedClientImages));
    } else {
      emit(LoadingMoreClientsState(
          clients: state.clients,
          cachedClientImages: state.cachedClientImages));
    }
    try {
      final response = await getClientsUseCase.call(state.clients);
      if (response != state.clients) {
        emit(ClientsDataState(
          clients: response,
          cachedClientImages: state.cachedClientImages,
        ));
      } else {
        emit(ClientsDataState(
          clients: state.clients,
          cachedClientImages: state.cachedClientImages,
        ));
      }
    } catch (e) {
      emit(ClientsDataState(
        clients: state.clients,
        cachedClientImages: state.cachedClientImages,
      ));
    }
  }

  void _searchClientEvent(
      SearchClientEvent event, Emitter<ClientListState> emit) {
    emit(SearchClientFromListState(
        clients: state.clients, cachedClientImages: state.cachedClientImages));
    emit(ClientsDataState(
      clients: state.clients,
      cachedClientImages: state.cachedClientImages,
    ));
  }

  void _refreshClientListEvent(
      RefreshClientListEvent event, Emitter<ClientListState> emit) async {
    emit(ClientsLoadingState(
        clients: state.clients, cachedClientImages: state.cachedClientImages));
    final response =
        await getClientsUseCase.call(const ClientsList(currentPage: 0));
    if (response != state.clients) {
      emit(ClientsDataState(
        clients: response,
        cachedClientImages: state.cachedClientImages,
      ));
    } else {
      emit(ClientsDataState(
        clients: state.clients,
        cachedClientImages: state.cachedClientImages,
      ));
    }
  }

  void _refreshClientEvent(
      RefreshClientEvent event, Emitter<ClientListState> emit) {
    final newClientList = <Client>[];
    newClientList.addAll(state.clients.clients);

    final index =
        newClientList.indexWhere((client) => client.id == event.client.id);
    newClientList[index] = event.client;
    emit(ClientsDataState(
      clients: ClientsList(
          clients: newClientList,
          nextPage: state.clients.nextPage,
          currentPage: state.clients.currentPage),
      cachedClientImages: state.cachedClientImages,
    ));
  }

  void _deleteClientEvent(
      DeleteClientEvent event, Emitter<ClientListState> emit) async {
    try {
      if (await deleteClientUseCase.call(event.client)) {
        final newClientList = <Client>[];
        newClientList.addAll(state.clients.clients);

        newClientList.removeWhere((client) => client.id == event.client.id);

        emit(ClientsDataState(
          clients: ClientsList(
              clients: newClientList,
              nextPage: state.clients.nextPage,
              currentPage: state.clients.currentPage),
          cachedClientImages: state.cachedClientImages,
        ));
      }
    } catch (e) {
      emit(ClientsDataState(
        clients: state.clients,
        cachedClientImages: state.cachedClientImages,
      ));
    }
  }
}