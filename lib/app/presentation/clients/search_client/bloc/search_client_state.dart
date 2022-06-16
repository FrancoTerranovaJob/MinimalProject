part of 'search_client_bloc.dart';

abstract class SearchClientState extends Equatable {
  const SearchClientState();
}

class SearchClientInitial extends SearchClientState {
  @override
  List<Object> get props => [];
}