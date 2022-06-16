import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_client_event.dart';
part 'search_client_state.dart';

class SearchClientBloc extends Bloc<SearchClientEvent, SearchClientState> {
  SearchClientBloc() : super(SearchClientInitial()) {
    on<SearchClientEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}