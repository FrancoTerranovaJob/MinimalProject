import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/login/bloc/login_bloc.dart';
import 'package:minimal/app/presentation/login/widgets/loading_progress/loading_progress.dart';
import 'package:minimal/app/presentation/login/widgets/login_background/login_background.dart';
import 'package:minimal/app/presentation/login/widgets/login_form/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) => LoginBloc(const LoginInitial()),
        child: Stack(
          children: [
            const LoginBackground(),
            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/minimal.png',
                        ),
                      ),
                      Flexible(
                          child: Text(
                        'LOG IN',
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )),
                      Expanded(flex: 2, child: LoginForm())
                    ],
                  ),
                ),
              ],
            ),
            const LoadingProgress()
          ],
        ));
  }
}