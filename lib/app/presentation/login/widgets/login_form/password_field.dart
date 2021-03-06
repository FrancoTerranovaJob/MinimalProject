import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/common/text_field/custom_text_field.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';

class PasswordField extends StatelessWidget {
  final Function(String text) onChange;
  final Function() onShowPressed;

  final TextEditingController textEditingController;

  const PasswordField(
      {Key? key,
      required this.onChange,
      required this.onShowPressed,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: _handleBuilding,
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 30, right: 30),
          child: CustomTextField(
              textEditingController: textEditingController,
              onChanged: (text) {
                onChange(text);
              },
              hintText: 'Password',
              hideText: !state.showPassword,
              suffixIcon: TextButton(
                onPressed: onShowPressed,
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                ),
              ),
              errorText: state.loginErrorType == LoginErrorType.password
                  ? 'Wrong password'
                  : null),
        );
      },
    );
  }

  bool _handleBuilding(LoginState previousState, LoginState currentState) {
    return (currentState is! AddingLoginCredentialsState ||
        (previousState.showPassword != currentState.showPassword));
  }
}