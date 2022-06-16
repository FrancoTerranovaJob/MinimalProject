import 'package:flutter/material.dart';

class ClientPageHeader extends StatelessWidget {
  const ClientPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          'CLIENTS',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}