import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/client_list.dart';
import 'package:minimal/app/presentation/clients/client_list/search_bar.dart';
import 'package:minimal/app/presentation/clients/client_page/widgets/client_page_background/client_page_background.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClientPageBackground(),
        BlocProvider(
          create: (context) =>
              ClientListBloc(ClientListInitial())..add(GetClientsEvent()),
          lazy: false,
          child: Column(
            children: [
              Expanded(
                  child: Row(
                children: [
                  SearchBar(),
                  DenseButton(
                    widthButton: 100,
                    buttonText: 'Add new',
                    onPressed: () {},
                  )
                ],
              )),
              Expanded(
                flex: 5,
                child: ClientList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}