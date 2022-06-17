import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/search_client/bloc/search_client_bloc.dart';
import 'package:minimal/app/presentation/common/text_field/custom_text_field.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchFieldController;
  const SearchField({Key? key, required this.searchFieldController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchClientBloc>(context);
    return CustomTextField(
      textEditingController: searchFieldController,
      hideText: false,
      onChanged: (String text) {
        searchBloc.add(OnTypingSearchEvent(text));
      },
      hintText: 'Search client...',
      hintColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
    );
  }
}