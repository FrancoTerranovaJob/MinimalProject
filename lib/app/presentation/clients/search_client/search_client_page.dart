import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/presentation/clients/client_list/widgets/client_card.dart';
import 'package:minimal/app/presentation/clients/search_client/bloc/search_client_bloc.dart';
import 'package:minimal/app/presentation/clients/search_client/widgets/client_not_found.dart';
import 'package:minimal/app/presentation/clients/search_client/widgets/empty_search.dart';
import 'package:minimal/app/presentation/clients/search_client/widgets/search_field.dart';

class SearchClientPage extends StatelessWidget {
  final List<Client> clients;
  final Map<int, Uint8List> cachedImages;
  final Function(Client client) onEditSelected;
  final Function(Client client) onDeleteSelected;
  final TextEditingController searchFieldController = TextEditingController();
  SearchClientPage(
      {Key? key,
      required this.clients,
      this.cachedImages = const {},
      required this.onEditSelected,
      required this.onDeleteSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.surface),
          elevation: 0,
          title: SearchField(
            searchFieldController: searchFieldController,
          )),
      body: SafeArea(
        child: BlocBuilder<SearchClientBloc, SearchClientState>(
          buildWhen: (p, c) =>
              p.temporalClientList.length != c.temporalClientList.length,
          builder: (context, state) {
            if (state.search.isEmpty) {
              return const EmptySearch();
            } else if (state.temporalClientList.isEmpty) {
              return const ClientNotFound();
            }
            return ListView.builder(
              itemCount: state.temporalClientList.length,
              itemBuilder: (BuildContext context, int index) {
                return ClientCard(
                  client: state.temporalClientList[index],
                  cachedImage: cachedImages[clients[index].id],
                  onImageRendered: (Uint8List image, int id) {},
                  onEditSelected: () =>
                      onEditSelected(state.temporalClientList[index]),
                  onDeleteSelected: () =>
                      onDeleteSelected(state.temporalClientList[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}