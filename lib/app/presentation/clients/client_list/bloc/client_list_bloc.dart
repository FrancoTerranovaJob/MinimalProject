import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';

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
    final response = await getClientsUseCase.call(state.clients);
    if (response != state.clients) {
      emit(ClientsDataState(
        clients: response,
        cachedClientImages: state.cachedClientImages,
      ));
    }
  }

  void _searchClientEvent(
      SearchClientEvent event, Emitter<ClientListState> emit) {
    emit(SearchClientState(
        clients: state.clients, cachedClientImages: state.cachedClientImages));
  }
}