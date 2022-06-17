import 'package:flutter/material.dart';

class ClientNotFound extends StatelessWidget {
  const ClientNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Center(
      child: Text(
        'The client does not exists',
        style: Theme.of(context).textTheme.headline1!.copyWith(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
      ),
    ));
  }
}