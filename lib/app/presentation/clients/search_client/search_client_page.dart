import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/presentation/clients/client_list/client_card.dart';
import 'package:minimal/app/presentation/clients/search_client/bloc/search_client_bloc.dart';
import 'package:minimal/app/presentation/common/text_field/custom_text_field.dart';

class SearchClientPage extends StatelessWidget {
  final List<Client> clients;
  final Map<int, Uint8List> cachedImages;
  final TextEditingController searchFieldController = TextEditingController();
  SearchClientPage(
      {Key? key, required this.clients, this.cachedImages = const {}})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchClientBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.surface),
        elevation: 0,
        title: CustomTextField(
          textEditingController: searchFieldController,
          hideText: false,
          onChanged: (String text) {
            searchBloc.add(OnTypingSearchEvent(text));
          },
          hintText: 'Buscar cliente...',
          hintColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        ),
      ),
      body: BlocBuilder<SearchClientBloc, SearchClientState>(
        buildWhen: (p, c) =>
            p.temporalClientList.length != c.temporalClientList.length,
        builder: (context, state) {
          if (state.temporalClientList.isEmpty) {}
          return ListView.builder(
            itemCount: state.temporalClientList.length,
            itemBuilder: (BuildContext context, int index) {
              return ClientCard(
                client: state.temporalClientList[index],
                cachedImage: cachedImages[clients[index].id],
                onImageRendered: (Uint8List image, int id) {},
              );
            },
          );
        },
      ),
    );
  }
}