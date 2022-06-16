import 'package:minimal/app/domain/client_domain/clients_repository/clients_repository.dart';
import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';

import 'package:minimal/di/get_it.dart';

class GetClientsUseCase {
  final clientRepository = services.get<ClientsRepository>();
  Future<ClientsList> call(ClientsList clientList) async {
    return await clientRepository.getClients(clientList);
  }
}

class SearchClientsUseCase {
  List<Client> call(List<Client> clients, String search) {
    final searchedClients = <Client>[];
    final lowerCaseSearch = search.toLowerCase();
    if (search.isEmpty) {
      return searchedClients;
    }
    if (search.length > 3) {
      if (search.contains('@')) {
        for (var client in clients) {
          var lowerCaseEmail = client.email.toLowerCase();
          if (lowerCaseEmail.contains(lowerCaseSearch)) {
            searchedClients.add(client);
          }
        }
      } else {
        for (var client in clients) {
          var lowerCaseFirstname = client.firstname.toLowerCase();
          var lowerCaseLastname = client.lastname.toLowerCase();
          var completeName = '$lowerCaseFirstname $lowerCaseLastname';
          if (lowerCaseFirstname.contains(lowerCaseSearch) ||
              lowerCaseLastname.contains(lowerCaseSearch) ||
              completeName.contains(lowerCaseSearch)) {
            searchedClients.add(client);
          }
        }
      }
      return searchedClients;
    }
    return [];
  }
}