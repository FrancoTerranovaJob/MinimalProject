import 'package:flutter/material.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';

class AddNewCLientButton extends StatelessWidget {
  const AddNewCLientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DenseButton(
      widthButton: 100,
      buttonText: 'Add new',
      onPressed: () {},
    );
  }
}