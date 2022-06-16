import 'package:equatable/equatable.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';

class ClientsList extends Equatable {
  final List<Client> clients;

  final String? nextPage;
  final int currentPage;

  const ClientsList({
    this.clients = const [],
    this.nextPage,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [
        clients,
        nextPage,
        currentPage,
      ];
}