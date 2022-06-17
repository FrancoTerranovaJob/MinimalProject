import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';

import 'package:minimal/di/get_it.dart';

part 'client_list_event.dart';
part 'client_list_state.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  final getClientsUseCase = services.get<GetClientsUseCase>();
  ClientListBloc(ClientListState initialState) : super(initialState) {
    on<AddCachedImage>(_addCachedImage);
    on<GetClientsEvent>(_getClientsEvent);
    on<SearchClientEvent>(_searchClientEvent);
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
}