import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';

abstract class ClientsRepository {
  Future<Client> addClientPhoto(Client client);
  Future<ClientsList> getClients(ClientsList clientList);
}