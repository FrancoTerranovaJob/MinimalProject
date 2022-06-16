import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        height: 50,
        child: ListTile(
          onTap: () {
            BlocProvider.of<ClientListBloc>(context).add(SearchClientEvent());
          },
          leading: Icon(Icons.search),
          title: Text('Buscar'),
        ),
      ),
    );
  }
}