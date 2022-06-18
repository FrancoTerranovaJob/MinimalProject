import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
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
        return Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(70)),
              onTap: () {
                BlocProvider.of<AddClientBloc>(context)
                    .add(SearchClientPhotoEvent());
              },
              child: Column(
                children: [
                  state.newClient.photo.isEmpty
                      ? const DefaultAvatar()
                      : SelectedAvatar(photo: state.newClient.photo),
                  Visibility(
                    visible: state.errorType == AddClientErrorType.invalidImage,
                    child: const Text('Invalid image!'),
                  )
                ],
              )),
        );
      },
    );
  }
}

class DefaultAvatar extends StatelessWidget {
  const DefaultAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        dashPattern: const [5, 5],
        color: Colors.yellow,
        borderType: BorderType.Circle,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 70,
          backgroundImage: null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_outlined,
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              ),
              Text(
                'Upload image',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.5),
                    ),
              )
            ],
          ),
        ));
  }
}

class SelectedAvatar extends StatelessWidget {
  final String photo;
  const SelectedAvatar({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      radius: 70,
      backgroundImage: MemoryImage(Uint8List.fromList(photo.codeUnits)),
    );
  }
}