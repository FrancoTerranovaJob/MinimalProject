import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal/app/presentation/clients/edit_client/bloc/edit_client_bloc.dart';
import 'package:minimal/app/presentation/clients/edit_client/widgets/edit_client_form/client_email.dart';
import 'package:minimal/app/presentation/clients/edit_client/widgets/edit_client_form/client_lastname.dart';
import 'package:minimal/app/presentation/clients/edit_client/widgets/edit_client_form/client_name.dart';

class EditClientForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController lastnameController;

  const EditClientForm(
      {Key? key,
      required this.emailController,
      required this.nameController,
      required this.lastnameController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editClientBloc = BlocProvider.of<EditClientBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: ClientName(
              textEditingController: nameController,
              onChanged: (text) =>
                  _editClientEvent(FirstNameChangedEvent(text), editClientBloc),
              hintText: 'First name*'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: ClientLastname(
              textEditingController: lastnameController,
              onChanged: (text) =>
                  _editClientEvent(LastNameChangedEvent(text), editClientBloc),
              hintText: 'Last name*'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: ClientEmail(
              textEditingController: emailController,
              onChanged: (text) =>
                  _editClientEvent(EmailChangedEvent(text), editClientBloc),
              hintText: 'Email address*'),
        ),
      ],
    );
  }

  void _editClientEvent(EditClientEvent event, EditClientBloc bloc) {
    bloc.add(event);
  }
}