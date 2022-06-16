part of 'search_client_bloc.dart';

abstract class SearchClientState extends Equatable {
  final String search;
  final List<Client> clients;
  final List<Client> temporalClientList;

  const SearchClientState(
      {required this.search,
      required this.clients,
      required this.temporalClientList});

  @override
  List<Object> get props => [search, clients, temporalClientList];
}

class SearchClientInitial extends SearchClientState {
  SearchClientInitial({required super.clients})
      : super(search: '', temporalClientList: []);
}

class SearchingClientState extends SearchClientState {
  const SearchingClientState(
      {required super.search,
      required super.clients,
      required super.temporalClientList});
}