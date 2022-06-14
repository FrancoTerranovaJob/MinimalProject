import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/home/bloc/home_bloc.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';
import 'package:minimal/app/presentation/login/widgets/login_form/email_field.dart';
import 'package:minimal/app/presentation/login/widgets/login_form/login_button.dart';
import 'package:minimal/app/presentation/login/widgets/login_form/password_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (p, c) => c is LoginSuccessState,
      listener: (context, state) {
        homeBloc.add(UserLoggedEvent());
      },
      child: Column(
        children: [
          EmailField(
            onChange: (text) =>
                _addLoginBlocEvent(EmailChangedEvent(text), loginBloc),
            onShowPressed: () =>
                _addLoginBlocEvent(ShowEmailEvent(), loginBloc),
          ),
          PasswordField(
            onChange: (text) =>
                _addLoginBlocEvent(PasswordChangedEvent(text), loginBloc),
            onShowPressed: () =>
                _addLoginBlocEvent(ShowPasswordEvent(), loginBloc),
          ),
          LoginButton(
            onPressed: () =>
                _addLoginBlocEvent(LoginButtonPressedEvent(), loginBloc),
          )
        ],
      ),
    );
  }

  void _addLoginBlocEvent(LoginEvent event, LoginBloc bloc) {
    bloc.add(event);
  }
}