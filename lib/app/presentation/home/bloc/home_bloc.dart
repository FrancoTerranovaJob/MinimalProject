import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/user_domain/entities/user.dart';
import 'package:minimal/app/domain/user_domain/use_cases/user_use_cases.dart';
import 'package:minimal/di/get_it.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final isLoggedUseCase = services.get<IsLoggedUseCase>();

  HomeBloc(HomeState initialState) : super(initialState) {
    on<CheckUserSessionEvent>(_emitLoginStatus);
    on<UserLoggedEvent>(_userLoggedEvent);
  }

  void _emitLoginStatus(HomeEvent event, Emitter emit) async {
    emit(LoadingState(loginStatus: state.loginStatus));
    final response = await isLoggedUseCase.call();
    if (response) {
      emit(const AppStatus(loginStatus: LoginStatus.logged));
    } else {
      emit(const AppStatus(loginStatus: LoginStatus.notLogged));
    }
  }

  void _userLoggedEvent(HomeEvent event, Emitter emit) async {
    emit(const AppStatus(loginStatus: LoginStatus.logged));
  }
}