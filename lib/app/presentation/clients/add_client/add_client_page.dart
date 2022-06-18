import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/client_photo.dart';
import 'package:minimal/app/presentation/clients/add_client/widgets/new_client_form/new_client_form.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';
import 'package:minimal/app/presentation/common/buttons/transparent_button.dart';
import 'package:minimal/app/presentation/common/progress/load_progress.dart';

class AddClientPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  AddClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addClientBloc = BlocProvider.of<AddClientBloc>(context);
    return BlocConsumer<AddClientBloc, AddClientState>(
      listener: (context, state) {
        if (state is AddClientSuccessState) {
          Navigator.of(context).pop();
        }
      },
      buildWhen: (p, c) =>
          c is AddClientErrorState || c is AddingClientLoadingState,
      builder: (context, state) {
        if (state is AddingClientLoadingState) {
          return const LoadProgress(
            opacity: 0,
          );
        }
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, bottom: 25.0, left: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Add New Client',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: constraints.maxHeight > 400,
                    child: const ClientPhoto()),
                Flexible(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: NewClientForm(
                        emailController: emailController,
                        nameController: nameController,
                        lastnameController: lastnameController),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: TransparentButton(
                              widthButton: 100,
                              heightButton: 50,
                              buttonText: 'Cancel',
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DenseButton(
                                widthButton: 150,
                                heightButton: 50,
                                buttonText: 'SAVE',
                                onPressed: () => _addNewClientEvent(
                                    OnCreateNewUserEvent(), addClientBloc),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addNewClientEvent(AddClientEvent event, AddClientBloc bloc) {
    bloc.add(event);
  }
}