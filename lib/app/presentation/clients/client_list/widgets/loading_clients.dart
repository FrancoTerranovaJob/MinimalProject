import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal/app/presentation/clients/client_list/bloc/client_list_bloc.dart';
import 'package:minimal/app/presentation/common/progress/load_progress.dart';

class LoadingClients extends StatelessWidget {
  const LoadingClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientListBloc, ClientListState>(
      builder: (context, state) {
        return Visibility(
          visible: state is LoadingMoreClientsState,
          child: const LoadProgress(
            opacity: 0,
          ),
        );
      },
    );
  }
}