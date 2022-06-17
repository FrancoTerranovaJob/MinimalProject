import 'package:minimal/app/data/clients_data/clients_api/request/create_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/post_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/update_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/add_client_response.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/edit_client_response.dart';

import 'package:minimal/app/data/clients_data/clients_api/response/post_client_response.dart';

abstract class ClientsApi {
  Future<PostClientResponse> getClients(PostClientRequest postClientRequest);
  Future<AddClientResponse> addClient(CreateClientRequest clientRequest);
  Future<EditClientResponse> updateClient(
      UpdateClientRequest updateClientRequest);
  Future<bool> deleteClient(int clientId);
}