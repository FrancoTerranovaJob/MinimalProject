import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/add_client/bloc/add_client_bloc.dart';
import 'package:minimal/app/presentation/common/text_field/custom_text_field.dart';

class ClientEmail extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String text) onChanged;
  final String hintText;

  const ClientEmail({
    Key? key,
    required this.textEditingController,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClientBloc, AddClientState>(
      builder: (context, state) {
        return CustomTextField(
            textEditingController: textEditingController,
            onChanged: onChanged,
            hintText: hintText,
            errorText:
                state.validationStatus == -3 ? 'The email is required' : null,
            hideText: false);
      },
    );
  }
}