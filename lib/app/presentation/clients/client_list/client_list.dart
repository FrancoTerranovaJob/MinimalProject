import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/client_card.dart';
import 'package:minimal/app/presentation/clients/client_list/loading_clients.dart';
import 'package:minimal/app/presentation/clients/search_client/bloc/search_client_bloc.dart';
import 'package:minimal/app/presentation/clients/search_client/search_client_page.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';
import 'package:minimal/app/presentation/common/progress/load_progress.dart';
import 'package:minimal/app/presentation/login/widgets/loading_progress/loading_progress.dart';

class ClientList extends StatelessWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocList = BlocProvider.of<ClientListBloc>(context);
    return BlocListener<ClientListBloc, ClientListState>(
      listener: (bContext, state) {
        if (state is SearchClientFromListState) {
          _searchClient(state, context);
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: BlocBuilder<ClientListBloc, ClientListState>(
                buildWhen: (p, c) => c is! ClientsLoadingState,
                builder: (context, state) {
                  final clientsList = state.clients.clients;

                  return ListView.builder(
                    itemCount: state.clients.clients.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index + 1 == state.clients.clients.length) {
                        return Column(
                          children: [
                            ClientCard(
                                client: clientsList[index],
                                cachedImage: state
                                    .cachedClientImages[clientsList[index].id],
                                onImageRendered:
                                    (Uint8List image, int clientId) =>
                                        _addClientListBlocEvent(
                                            AddCachedImage(
                                                image: image,
                                                clientId: clientId),
                                            blocList)),
                            const SizedBox(height: 100, child: LoadingClients())
                          ],
                        );
                      }
                      return ClientCard(
                          client: clientsList[index],
                          cachedImage:
                              state.cachedClientImages[clientsList[index].id],
                          onImageRendered: (Uint8List image, int clientId) =>
                              _addClientListBlocEvent(
                                  AddCachedImage(
                                      image: image, clientId: clientId),
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

  void _searchClient(SearchClientFromListState state, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => SearchClientBloc(
                  SearchClientInitial(clients: state.clients.clients)),
              child: SearchClientPage(
                clients: state.clients.clients,
                cachedImages: state.cachedClientImages,
              ),
            )));
  }
}