part of 'search_client_bloc.dart';

abstract class SearchClientEvent extends Equatable {
  const SearchClientEvent();
}

class OnTypingSearchEvent extends SearchClientEvent {
  final String search;

  const OnTypingSearchEvent(this.search);

  @override
  List<Object> get props => [search];
}

class RefreshClientEvent extends SearchClientEvent {
  final Client client;

  RefreshClientEvent({required this.client});
  @override
  List<Object> get props => [client];
}