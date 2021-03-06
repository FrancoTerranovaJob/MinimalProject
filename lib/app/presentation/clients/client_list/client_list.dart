import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/widgets/client_card.dart';
import 'package:minimal/app/presentation/clients/client_list/widgets/loading_clients.dart';
import 'package:minimal/app/presentation/clients/edit_client/bloc/edit_client_bloc.dart';
import 'package:minimal/app/presentation/clients/edit_client/edit_client_page.dart';

import 'package:minimal/app/presentation/clients/search_client/bloc/search_client_bloc.dart'
    as search_bloc;
import 'package:minimal/app/presentation/clients/search_client/search_client_page.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';
import 'package:minimal/app/presentation/common/progress/load_progress.dart';

class ClientList extends StatelessWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocList = BlocProvider.of<ClientListBloc>(context);
    return BlocListener<ClientListBloc, ClientListState>(
      listener: (bContext, state) {
        if (state is SearchClientFromListState) {
          _searchClient(state, context, blocList);
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: BlocBuilder<ClientListBloc, ClientListState>(
                buildWhen: (p, c) => c is! LoadingMoreClientsState,
                builder: (context, state) {
                  final clientsList = state.clients.clients;
                  if (state is ClientsLoadingState) {
                    return const LoadProgress(
                      opacity: 0,
                    );
                  }
                  return ListView.builder(
                    itemCount: clientsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index + 1 == clientsList.length) {
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
                                              image: image, clientId: clientId),
                                          blocList),
                              onEditSelected: () {
                                _onEditSelected(
                                    clientsList[index], context, blocList);
                              },
                              onDeleteSelected: () {},
                            ),
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
                                blocList),
                        onEditSelected: () async {
                          await _onEditSelected(
                              clientsList[index], context, blocList);
                        },
                        onDeleteSelected: () {
                          _addClientListBlocEvent(
                              DeleteClientEvent(client: clientsList[index]),
                              blocList);
                        },
                      );
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

  void _searchClient(SearchClientFromListState state, BuildContext context,
      ClientListBloc clientListBloc) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (bContext) => BlocProvider(
        create: (context) => search_bloc.SearchClientBloc(
            search_bloc.SearchClientInitial(clients: state.clients.clients)),
        child: SearchClientPage(
          clients: state.clients.clients,
          cachedImages: state.cachedClientImages,
          onEditSelected: (Client client) {
            Navigator.of(context).pop();
            _onEditSelected(client, context, clientListBloc);
          },
          onDeleteSelected: (Client client) {
            Navigator.of(context).pop();
            _addClientListBlocEvent(
                DeleteClientEvent(client: client), clientListBloc);
          },
        ),
      ),
    ));
  }

  Future _onEditSelected(
      Client client, BuildContext context, ClientListBloc bloc) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: BlocProvider(
              lazy: false,
              create: (context) =>
                  EditClientBloc(EditClientInitial(client: client)),
              child: EditClientPage(
                onEditSuccess: (Client client) {
                  _addClientListBlocEvent(
                      RefreshClientEvent(client: client), bloc);
                },
              ),
            ),
          );
        });
  }
}