import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_email.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_lastname.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_name.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';
import 'package:minimal/app/presentation/common/buttons/transparent_button.dart';

class NewClientForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController lastnameController;
  final ScrollController scrollController = ScrollController();
  NewClientForm(
      {Key? key,
      required this.emailController,
      required this.nameController,
      required this.lastnameController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addClientBloc = BlocProvider.of<AddClientBloc>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Text(
              'Add New Client',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Flexible(
          flex: 6,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    BlocBuilder<AddClientBloc, AddClientState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<AddClientBloc>(context)
                                .add(SearchClientPhotoEvent());
                          },
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: state.newClient.photo.isNotEmpty
                                ? MemoryImage(Uint8List.fromList(
                                    state.newClient.photo.codeUnits))
                                : null,
                          ),
                        );
                      },
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: ClientName(
                              textEditingController: nameController,
                              onChanged: (text) => _addNewClientEvent(
                                  FirstNameChangedEvent(text), addClientBloc),
                              hintText: 'First name*'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClientLastname(
                            textEditingController: lastnameController,
                            onChanged: (text) => _addNewClientEvent(
                                LastNameChangedEvent(text), addClientBloc),
                            hintText: 'Last name*'),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClientEmail(
                            textEditingController: emailController,
                            onChanged: (text) => _addNewClientEvent(
                                EmailChangedEvent(text), addClientBloc),
                            hintText: 'Email address*'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TransparentButton(
                widthButton: 100,
                heightButton: 50,
                buttonText: 'Cancelar',
                onPressed: () {},
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DenseButton(
                  widthButton: 150,
                  heightButton: 50,
                  buttonText: 'Aceptar',
                  onPressed: () =>
                      _addNewClientEvent(OnCreateNewUserEvent(), addClientBloc),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addNewClientEvent(AddClientEvent event, AddClientBloc bloc) {
    bloc.add(event);
  }
}