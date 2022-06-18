import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/use_cases/clients_use_cases.dart';

import 'package:minimal/di/get_it.dart';

part 'search_client_event.dart';
part 'search_client_state.dart';

class SearchClientBloc extends Bloc<SearchClientEvent, SearchClientState> {
  final searchClientsUseCase = services.get<SearchClientsUseCase>();
  SearchClientBloc(SearchClientState initialState) : super(initialState) {
    on<OnTypingSearchEvent>(_onTypingSearchEvent);
  }

  void _onTypingSearchEvent(
      OnTypingSearchEvent event, Emitter<SearchClientState> emit) {
    final searchResult = searchClientsUseCase.call(state.clients, event.search);
    emit(SearchingClientState(
        search: event.search,
        clients: state.clients,
        temporalClientList: searchResult));
  }
}