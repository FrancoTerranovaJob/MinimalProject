import 'package:minimal/app/domain/client_domain/clients_repository/clients_repository.dart';
import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';

import 'package:minimal/di/get_it.dart';

class GetClientsUseCase {
  final clientRepository = services.get<ClientsRepository>();
  Future<ClientsList> call(ClientsList clientList) async {
    return await clientRepository.getClients(clientList);
  }
}