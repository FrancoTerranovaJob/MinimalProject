import 'package:flutter/material.dart';

class DenseButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final double widthButton;
  final double heightButton;
  final bool rounded;
  const DenseButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.widthButton = double.infinity,
      this.rounded = true,
      this.heightButton = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      height: heightButton,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return 0;
              }
              return 10.0;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: rounded
                  ? BorderRadius.circular(25.0)
                  : BorderRadius.circular(0),
            )),
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.surface;
              }
              return Theme.of(context).colorScheme.secondary;
            })),
        child: Text(
          buttonText,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}