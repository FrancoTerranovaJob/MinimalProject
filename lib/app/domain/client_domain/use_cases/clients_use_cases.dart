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
    if (lowerCaseSearch.contains('@')) {
      for (var client in clients) {
        var lowerCaseEmail = client.email.toLowerCase();
        if (lowerCaseEmail.contains(lowerCaseSearch)) {
          searchedClients.add(client);
        }
      }
      return searchedClients;
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
      return searchedClients;
    }
  }
}

class ValidateNewClientDataUseCase {
  int call(Client newClient) {
    return newClient.firstname.isEmpty
        ? -1
        : newClient.lastname.isEmpty
            ? -2
            : newClient.email.isEmpty
                ? -3
                : 1;
  }
}

class SearchClientPhotoUseCase {
  final clientRepository = services.get<ClientsRepository>();
  Future<Client> call(Client newClient) async {
    return await clientRepository.searchClientPhoto(newClient);
  }
}

class AddClientUseCase {
  final clientRepository = services.get<ClientsRepository>();
  Future<void> call(Client newClient) async {
    try {
      await clientRepository.addNewClient(newClient);
    } catch (e) {
      rethrow;
    }
  }
}

class SaveEditedClientUseCase {
  final clientRepository = services.get<ClientsRepository>();
  Future<bool> call(Client editedClient) async {
    try {
      await clientRepository.editClient(editedClient);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}