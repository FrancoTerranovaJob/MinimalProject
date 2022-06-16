part of 'client_list_bloc.dart';

abstract class ClientListState extends Equatable {
  final ClientsList clients;

  final Map<int, Uint8List> cachedClientImages;
  const ClientListState({
    required this.clients,
    required this.cachedClientImages,
  });
  @override
  List<Object> get props => [clients, cachedClientImages];
}

class ClientListInitial extends ClientListState {
  ClientListInitial()
      : super(
          clients: const ClientsList(),
          cachedClientImages: {},
        );
}

class ClientsDataState extends ClientListState {
  const ClientsDataState({
    required super.clients,
    required super.cachedClientImages,
  });
}

class ClientsErrorState extends ClientListState {
  const ClientsErrorState({
    required super.clients,
    required super.cachedClientImages,
  });
}

class ClientsLoadingState extends ClientListState {
  const ClientsLoadingState({
    required super.clients,
    required super.cachedClientImages,
  });
}

class SearchClientFromListState extends ClientListState {
  const SearchClientFromListState({
    required super.clients,
    required super.cachedClientImages,
  });
}