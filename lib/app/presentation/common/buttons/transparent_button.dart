import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final double widthButton;
  final double heightButton;
  const TransparentButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.widthButton = double.infinity,
      this.heightButton = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      height: heightButton,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}