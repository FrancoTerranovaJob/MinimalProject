part of 'client_list_bloc.dart';

abstract class ClientListEvent extends Equatable {
  const ClientListEvent();
}

class AddCachedImage extends ClientListEvent {
  final Uint8List image;
  final int clientId;

  const AddCachedImage({required this.image, required this.clientId});

  @override
  List<Object> get props => [image, clientId];
}

class GetClientsEvent extends ClientListEvent {
  @override
  List<Object> get props => [];
}

class SearchClientEvent extends ClientListEvent {
  @override
  List<Object> get props => [];
}

class RefreshClientListEvent extends ClientListEvent {
  @override
  List<Object> get props => [];
}

class RefreshClientEvent extends ClientListEvent {
  final Client client;

  RefreshClientEvent({required this.client});
  @override
  List<Object> get props => [client];
}

class DeleteClientEvent extends ClientListEvent {
  final Client client;

  DeleteClientEvent({required this.client});
  @override
  List<Object> get props => [client];
}

class SearchedClientDeleted extends ClientListEvent {
  final Client client;

  SearchedClientDeleted({required this.client});
  @override
  List<Object> get props => [client];
}