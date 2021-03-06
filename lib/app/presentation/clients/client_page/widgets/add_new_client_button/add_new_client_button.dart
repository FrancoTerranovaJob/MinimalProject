import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/clients/client_page/widgets/add_new_client_dialog/add_new_client_dialog.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';

class AddNewCLientButton extends StatelessWidget {
  const AddNewCLientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DenseButton(
      widthButton: 100,
      buttonText: 'Add new',
      onPressed: () async {
        await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const AddNewClientDialog();
                })
            .then((value) => BlocProvider.of<ClientListBloc>(context)
                .add(RefreshClientListEvent()));
      },
    );
  }
}