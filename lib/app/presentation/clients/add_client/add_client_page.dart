import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/new_client_form.dart';
import 'package:minimal/app/presentation/common/progress/load_progress.dart';

class AddClientPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  AddClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClientBloc, AddClientState>(
      builder: (BuildContext context, state) {
        if (state is AddingClientLoadingState) {
          return LoadProgress(
            opacity: 0,
          );
        }
        return NewClientForm(
            emailController: emailController,
            nameController: nameController,
            lastnameController: lastnameController);
      },
    );
  }
}