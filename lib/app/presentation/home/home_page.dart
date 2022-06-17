import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal/app/presentation/clients/client_page/client_page.dart';
import 'package:minimal/app/presentation/home/bloc/home_bloc.dart';
import 'package:minimal/app/presentation/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is AppStatus) {
              if (state.loginStatus == LoginStatus.logged) {
                return _loggedPage();
              }
              return _notLoggedPage();
            }

            if (state is ErrorState) {}
            return _loadingPage();
          },
        ),
      ),
    );
  }

  Widget _loggedPage() {
    return const ClientPage();
  }

  Widget _notLoggedPage() {
    return const LoginPage();
  }

  Widget _loadingPage() {
    return Container();
  }
}