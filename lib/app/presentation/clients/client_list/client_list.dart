import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/client_card.dart';
import 'package:minimal/app/presentation/clients/search_client/search_client_page.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';

class ClientList extends StatelessWidget {
  ClientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocList = BlocProvider.of<ClientListBloc>(context);
    return BlocListener<ClientListBloc, ClientListState>(
      listenWhen: (p, c) => c is SearchClientState,
      listener: (context, state) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchClientPage(
                  clients: state.clients.clients,
                  cachedImages: state.cachedClientImages,
                )));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: BlocBuilder<ClientListBloc, ClientListState>(
                builder: (context, state) {
              return ListView.builder(
                itemCount: state.clients.temporalClientList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClientCard(
                      client: state.clients.temporalClientList[index],
                      cachedImage: state.cachedClientImages[
                          state.clients.temporalClientList[index].id],
                      onImageRendered: (Uint8List image, int clientId) =>
                          _addClientListBlocEvent(
                              AddCachedImage(image: image, clientId: clientId),
                              blocList));
                },
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DenseButton(
                onPressed: () =>
                    _addClientListBlocEvent(GetClientsEvent(), blocList),
                buttonText: 'Load More',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addClientListBlocEvent(ClientListEvent event, ClientListBloc bloc) {
    bloc.add(event);
  }
}