import 'package:flutter/material.dart';
import 'package:minimal/app/presentation/clients/edit_client/bloc/edit_client_bloc.dart';
import 'package:minimal/app/presentation/common/text_field/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientLastname extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String text) onChanged;
  final String hintText;

  const ClientLastname(
      {Key? key,
      required this.textEditingController,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditClientBloc, EditClientState>(
      buildWhen: (p, c) => p.validationStatus != c.validationStatus,
      builder: (context, state) {
        return CustomTextField(
            textEditingController: textEditingController,
            onChanged: onChanged,
            hintText: hintText,
            errorText: state.validationStatus == -2
                ? 'The lastname is required'
                : null,
            hideText: false);
      },
    );
  }
}