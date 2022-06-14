import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/common/text_field/custom_text_field.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: EmailField(
            onChange: (text) =>
                _addLoginBlocEvent(EmailChangedEvent(text), loginBloc),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PasswordField(
            onChange: (text) =>
                _addLoginBlocEvent(PasswordChangedEvent(text), loginBloc),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoginButton(
            onPressed: () =>
                _addLoginBlocEvent(LoginButtonPressedEvent(), loginBloc),
          ),
        )
      ],
    );
  }

  void _addLoginBlocEvent(LoginEvent event, LoginBloc bloc) {
    bloc.add(event);
  }
}

class EmailField extends StatelessWidget {
  final Function(String text) onChange;

  const EmailField({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextField(
          textEditingController: TextEditingController(),
          text: '',
          onChanged: onChange,
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  final Function(String text) onChange;

  const PasswordField({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextField(
          textEditingController: TextEditingController(),
          text: '',
          onChanged: onChange,
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function() onPressed;

  const LoginButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: onPressed,
          child: Text('Login'),
        );
      },
    );
  }
}