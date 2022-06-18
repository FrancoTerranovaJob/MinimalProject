import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_email.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_lastname.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_name.dart';

class NewClientForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController lastnameController;

  const NewClientForm(
      {Key? key,
      required this.emailController,
      required this.nameController,
      required this.lastnameController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addClientBloc = BlocProvider.of<AddClientBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: ClientName(
              textEditingController: nameController,
              onChanged: (text) => _addNewClientEvent(
                  FirstNameChangedEvent(text), addClientBloc),
              hintText: 'First name*'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: ClientLastname(
              textEditingController: lastnameController,
              onChanged: (text) =>
                  _addNewClientEvent(LastNameChangedEvent(text), addClientBloc),
              hintText: 'Last name*'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: ClientEmail(
              textEditingController: emailController,
              onChanged: (text) =>
                  _addNewClientEvent(EmailChangedEvent(text), addClientBloc),
              hintText: 'Email address*'),
        ),
      ],
    );
  }

  void _addNewClientEvent(AddClientEvent event, AddClientBloc bloc) {
    bloc.add(event);
  }
}