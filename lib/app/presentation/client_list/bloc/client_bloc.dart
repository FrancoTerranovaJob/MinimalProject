import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimal/app/domain/user_domain/entities/user.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(ClientInitial()) {
    on<ClientEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}