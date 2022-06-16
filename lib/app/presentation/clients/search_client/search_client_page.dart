import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/presentation/clients/client_list/client_card.dart';

class SearchClientPage extends StatelessWidget {
  final List<Client> clients;
  final Map<int, Uint8List> cachedImages;
  const SearchClientPage(
      {Key? key, required this.clients, this.cachedImages = const {}})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (BuildContext context, int index) {
          return ClientCard(
            client: clients[index],
            cachedImage: cachedImages[clients[index].id],
            onImageRendered: (Uint8List image, int id) {},
          );
        },
      ),
    );
  }
}