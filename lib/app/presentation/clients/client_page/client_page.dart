import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/client_list.dart';

import 'package:minimal/app/presentation/clients/client_page/widgets/add_new_client_button/add_new_client_button.dart';

import 'package:minimal/app/presentation/clients/client_page/widgets/client_page_background/client_page_background.dart';
import 'package:minimal/app/presentation/clients/client_page/widgets/client_page_header/client_page_header.dart';
import 'package:minimal/app/presentation/clients/client_page/widgets/client_search_bar/client_search_bar.dart';

import 'package:minimal/app/presentation/common/app_logo/app_logo.dart';

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
              const Flexible(
                  flex: 2,
                  child: Center(
                      child: AppLogo(
                    width: 100,
                    height: 100,
                  ))),
              const Flexible(child: ClientPageHeader()),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: const [
                      Flexible(child: ClientSearchBar()),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AddNewCLientButton())
                    ],
                  )),
              const Expanded(
                flex: 10,
                child: ClientList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}