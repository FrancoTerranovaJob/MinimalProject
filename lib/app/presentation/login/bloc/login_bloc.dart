import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/common/exceptions/api_exception.dart';
import 'package:minimal/app/data/user_data/user_api/exceptions/user_api_exceptions.dart';
import 'package:minimal/app/domain/user_domain/entities/login.dart';
import 'package:minimal/app/domain/user_domain/use_cases/user_use_cases.dart';
import 'package:minimal/app/domain/user_domain/user_repository/exceptions/user_repository_exceptions.dart';
import 'package:minimal/di/get_it.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final loginUseCase = services.get<LoginUseCase>();
  final isValidLoginUseCase = services.get<IsValidLoginUseCase>();
  LoginBloc(LoginState loginInitial) : super(loginInitial) {
    on<EmailChangedEvent>(_onEmailChanged);

    on<PasswordChangedEvent>(_onPasswordChanged);

    on<LoginButtonPressedEvent>(_onLoginButtonPressed);

    on<ShowEmailEvent>(_showEmailEvent);

    on<ShowPasswordEvent>(_showPasswordEvent);
  }

  void _onEmailChanged(EmailChangedEvent event, Emitter<LoginState> emit) {
    final changedLogin =
        Login(email: event.email, password: state.login.password);
    emit(AddingLoginCredentialsState(
        login: changedLogin,
        enableButton: isValidLoginUseCase.call(changedLogin),
        showEmail: state.showEmail,
        showPassword: state.showPassword));
  }

  void _onPasswordChanged(
      PasswordChangedEvent event, Emitter<LoginState> emit) {
    final changedLogin =
        Login(email: state.login.email, password: event.password);
    emit(AddingLoginCredentialsState(
        login: changedLogin,
        enableButton: isValidLoginUseCase.call(changedLogin),
        showEmail: state.showEmail,
        showPassword: state.showPassword));
  }

  void _onLoginButtonPressed(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingstate(
        login: state.login,
        enableButton: state.enableButton,
        showEmail: state.showEmail,
        showPassword: state.showPassword));
    try {
      final response = await loginUseCase.call(state.login);
      if (response) {
        emit(LoginSuccessState(
            login: state.login,
            enableButton: state.enableButton,
            showEmail: state.showEmail,
            showPassword: state.showPassword));
      }
    } on LoginUserRepositoryException catch (e) {
      final errorType = _handleLoginErrors(e);
      emit(LoginErrorState(
        login: state.login,
        enableButton: state.enableButton,
        loginErrorType: errorType,
        showEmail: state.showEmail,
        showPassword: state.showPassword,
      ));
    }
  }

  void _showEmailEvent(ShowEmailEvent event, Emitter<LoginState> emit) {
    emit(AddingLoginCredentialsState(
        login: state.login,
        enableButton: state.enableButton,
        showEmail: !state.showEmail,
        showPassword: state.showPassword));
  }

  void _showPasswordEvent(ShowPasswordEvent event, Emitter<LoginState> emit) {
    emit(AddingLoginCredentialsState(
        login: state.login,
        enableButton: state.enableButton,
        showEmail: state.showEmail,
        showPassword: !state.showPassword));
  }

  LoginErrorType _handleLoginErrors(LoginUserRepositoryException e) {
    if (e.failedLogin != null) {
      if (e.failedLogin!.errorNumber == -2) {
        return LoginErrorType.account;
      }
      return LoginErrorType.password;
    }
    if (e.error is ApiException) {
    } else if (e.error is DioException) {}

    return LoginErrorType.unknown;
  }
}