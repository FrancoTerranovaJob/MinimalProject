import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  final String? errorText;
  final bool hideText;
  final Widget? suffixIcon;
  final TextInputType inputType;
  final String hintText;
  final Function(String text) onChanged;

  const CustomTextField(
      {Key? key,
      required this.textEditingController,
      required this.text,
      required this.onChanged,
      required this.hideText,
      this.inputType = TextInputType.text,
      this.suffixIcon,
      this.errorText,
      this.hintText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hideText,
      onChanged: onChanged,
      keyboardType: inputType,
      controller: textEditingController,
      style: Theme.of(context).textTheme.subtitle1,
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
          errorText: errorText, suffixIcon: suffixIcon, hintText: hintText),
    );
  }
}