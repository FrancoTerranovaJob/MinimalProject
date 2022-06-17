import 'package:flutter/material.dart';
import 'package:minimal/app/presentation/common/buttons/dense_button.dart';

class ClientOptions extends StatelessWidget {
  final Function() onEditSelected;
  final Function() onDeleteSelected;
  final Icon icon;
  const ClientOptions(
      {Key? key,
      required this.onEditSelected,
      required this.onDeleteSelected,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        color: Theme.of(context).colorScheme.surface,
        icon: icon,
        onSelected: (int item) async {
          if (item == 0) {
            onEditSelected();
          } else {
            onDeleteSelected();
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                padding: EdgeInsets.all(0),
                value: 0,
                child: DenseButton(
                  buttonText: 'Edit',
                  rounded: false,
                ),
              ),
              const PopupMenuItem<int>(
                padding: EdgeInsets.all(0),
                value: 1,
                child: DenseButton(
                  buttonText: 'Delete',
                  rounded: false,
                ),
              ),
            ]);
  }
}