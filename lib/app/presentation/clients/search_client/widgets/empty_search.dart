import 'package:flutter/material.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          'Type a name or email for search',
          style: Theme.of(context).textTheme.headline1!.copyWith(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
        ),
      ),
    );
  }
}