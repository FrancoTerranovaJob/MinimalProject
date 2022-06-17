import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/add_client_page.dart';
import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';

class AddNewClientDialog extends StatelessWidget {
  const AddNewClientDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: BlocProvider(
        lazy: false,
        create: (context) => AddClientBloc(),
        child: AddClientPage(),
      ),
    );
  }
}