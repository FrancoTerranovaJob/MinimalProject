import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final Function(Uint8List image, int id) onImageRendered;
  final Uint8List? cachedImage;
  const ClientCard(
      {Key? key,
      required this.client,
      required this.onImageRendered,
      this.cachedImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(width: 1.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: _getClientImage(),
                ),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: Center(
                  child: ListTile(
                      title: Text(
                        '${client.firstname} ${client.lastname}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        client.email,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.6)),
                        textAlign: TextAlign.start,
                      )),
                ),
              )
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
    );
  }

  MemoryImage? _getClientImage() {
    if (client.photo.trim().isNotEmpty) {
      if (cachedImage != null) {
        return MemoryImage(cachedImage!);
      } else if (client.photo.codeUnits.isNotEmpty) {
        final clientImage = Uint8List.fromList(client.photo.codeUnits);
        onImageRendered(clientImage, client.id);
        return MemoryImage(clientImage);
      }
    }

    return null;
  }
}