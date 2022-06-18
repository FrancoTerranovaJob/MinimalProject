import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/presentation/clients/edit_client/bloc/edit_client_bloc.dart';
import 'package:minimal/app/presentation/clients/edit_client/widgets/edit_client_form/client_photo.dart';
import 'package:minimal/app/presentation/clients/edit_client/widgets/edit_client_form/edit_client_form.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';
import 'package:minimal/app/presentation/common/buttons/transparent_button.dart';
import 'package:minimal/app/presentation/common/progress/load_progress.dart';

class EditClientPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final Function(Client client) onEditSuccess;
  EditClientPage({Key? key, required this.onEditSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editClientBloc = BlocProvider.of<EditClientBloc>(context);
    emailController.text = editClientBloc.state.client.email;
    nameController.text = editClientBloc.state.client.firstname;
    lastnameController.text = editClientBloc.state.client.lastname;
    return BlocConsumer<EditClientBloc, EditClientState>(
      listener: (context, state) {
        if (state is EditClientSuccessState) {
          onEditSuccess(state.client);
          Navigator.of(context).pop();
        }
      },
      buildWhen: (p, c) =>
          c is EditClientErrorState || c is EditClientLoadingState,
      builder: (context, state) {
        if (state is EditClientLoadingState) {
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
                        'Edit Client',
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
                    child: EditClientForm(
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
                                onPressed: () => _addEditClientEvent(
                                    OnSaveEditEvent(), editClientBloc),
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

  void _addEditClientEvent(EditClientEvent event, EditClientBloc bloc) {
    bloc.add(event);
  }
}