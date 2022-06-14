import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  final Function() onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 26.0, left: 26.0, top: 30.0),
          child: DenseButton(
            onPressed: state.enableButton ? onPressed : null,
            buttonText: 'LOG IN',
          ),
        );
      },
    );
  }
}