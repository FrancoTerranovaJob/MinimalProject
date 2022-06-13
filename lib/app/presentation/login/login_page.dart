import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';
import 'package:minimal/app/presentation/login/widgets/login_form/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => LoginBloc(),
      child: ListView(
        children: const [
          Expanded(child: Text('Title')),
          Expanded(flex: 3, child: LoginForm())
        ],
      ),
    );
  }
}