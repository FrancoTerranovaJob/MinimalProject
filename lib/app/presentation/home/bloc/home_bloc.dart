import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState) {
    on<CheckUserSessionEvent>(_emitLoginStatus);
  }

  void _emitLoginStatus(HomeEvent event, Emitter emit) async {
    emit(LoadingState(loginStatus: state.loginStatus));
  }
}