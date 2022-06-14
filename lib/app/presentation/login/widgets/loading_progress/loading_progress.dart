import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Visibility(
          visible: state is LoginLoadingstate,
          child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              child: Center(
                child: Lottie.asset(
                  'assets/progress.json',
                  width: 250,
                  height: 200,
                ),
              )),
        );
      },
    );
  }
}