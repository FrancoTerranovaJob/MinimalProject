import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';

class ClientSearchBar extends StatelessWidget {
  const ClientSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SizedBox(
        width: 300,
        height: 50,
        child: ListTile(
          onTap: () {
            BlocProvider.of<ClientListBloc>(context).add(SearchClientEvent());
          },
          leading: const Icon(Icons.search),
          title: const Text('Buscar'),
        ),
      ),
    );
  }
}