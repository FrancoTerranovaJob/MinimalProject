import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';

class ClientPhoto extends StatelessWidget {
  const ClientPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClientBloc, AddClientState>(
      buildWhen: (p, c) => p.newClient.photo != c.newClient.photo,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<AddClientBloc>(context)
                .add(SearchClientPhotoEvent());
          },
          child: CircleAvatar(
            radius: 70,
            backgroundImage: state.newClient.photo.isNotEmpty
                ? MemoryImage(
                    Uint8List.fromList(state.newClient.photo.codeUnits))
                : null,
          ),
        );
      },
    );
  }
}