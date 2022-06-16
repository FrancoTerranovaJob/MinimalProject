import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal/app/presentation/home/bloc/home_bloc.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';

import 'package:minimal/app/presentation/login/widgets/login_form/email_field.dart';

import 'package:minimal/app/presentation/login/widgets/login_form/login_button.dart';
import 'package:minimal/app/presentation/login/widgets/login_form/password_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (p, c) => c is LoginSuccessState,
      listener: (context, state) {
        homeBloc.add(UserLoggedEvent());
      },
      child: Stack(
        children: [
          Column(
            children: [
              EmailField(
                textEditingController: emailController,
                onChange: (text) =>
                    _addLoginBlocEvent(EmailChangedEvent(text), loginBloc),
                onShowPressed: () =>
                    _addLoginBlocEvent(ShowEmailEvent(), loginBloc),
              ),
              PasswordField(
                textEditingController: passwordController,
                onChange: (text) =>
                    _addLoginBlocEvent(PasswordChangedEvent(text), loginBloc),
                onShowPressed: () =>
                    _addLoginBlocEvent(ShowPasswordEvent(), loginBloc),
              ),
              LoginButton(onPressed: () {
                FocusScope.of(context).unfocus();
                _addLoginBlocEvent(LoginButtonPressedEvent(), loginBloc);
              }),
            ],
          ),
        ],
      ),
    );
  }

  void _addLoginBlocEvent(LoginEvent event, LoginBloc bloc) {
    bloc.add(event);
  }
}