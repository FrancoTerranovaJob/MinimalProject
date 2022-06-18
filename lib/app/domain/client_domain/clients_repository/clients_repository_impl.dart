import 'package:minimal/app/common/exceptions/api_exception.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api.dart';
import 'package:minimal/app/data/clients_data/clients_api/exceptions/client_api_exceptions.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/create_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/post_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/update_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/add_client_response.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/client_response.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/edit_client_response.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/post_client_response.dart';
import 'package:minimal/app/data/files_picker/files_picker.dart';
import 'package:minimal/app/data/files_picker/response/read_jpg_response.dart';
import 'package:minimal/app/domain/client_domain/clients_repository/clients_repository.dart';
import 'package:minimal/app/domain/client_domain/clients_repository/exceptions/client_repository_exceptions.dart';

import 'package:minimal/app/domain/client_domain/entities/client.dart';
import 'package:minimal/app/domain/client_domain/entities/clients_list.dart';

import 'package:minimal/di/get_it.dart';

class ClientsRepositoryImpl extends ClientsRepository {
  final filePicker = services.get<FilesPicker>();
  final api = services.get<ClientsApi>();
  @override
  Future<Client> searchClientPhoto(Client client) async {
    final ReadJpgResponse response = await filePicker.readJPG();
    if (response.jpg != null) {
      return Client(
          id: client.id,
          firstname: client.firstname,
          lastname: client.lastname,
          email: client.email,
          address: client.address,
          photo: response.jpg!,
          caption: client.caption);
    }
    return client;
  }

  @override
  Future<ClientsList> getClients(ClientsList clientList) async {
    try {
      if (clientList.currentPage == 0) {
        final PostClientResponse response =
            await api.getClients(const PostClientRequest(pageNumber: 1));

        return _getClientsList(response, clientList);
      } else if (clientList.nextPage != null) {
        final int nextPage = clientList.currentPage + 1;
        final PostClientResponse response =
            await api.getClients(PostClientRequest(pageNumber: nextPage));
        return _getClientsList(response, clientList);
      }
      return clientList;
    } on DioException catch (e) {
      throw GetClientsRepositoryException(e, 'Network Exception');
    } on ApiException catch (e) {
      throw GetClientsRepositoryException(e, 'Clients Api Exception');
    } catch (e) {
      throw GetClientsRepositoryException(
          e, 'get clients repository Exception');
    }
  }

  @override
  Future<bool> addNewClient(Client client) async {
    try {
      final AddClientResponse response = await api.addClient(
          CreateClientRequest(
              firstname: client.firstname,
              lastname: client.lastname,
              email: client.email,
              address: client.address,
              photo: client.photo,
              caption: client.caption));
      if (response is AddClientSuccessResponse) {
        return true;
      }
      throw AddClientRepositoryException(
          addClientFailedResponse: response as AddClientFailedResponse,
          response,
          'Failed to add new client exception');
    } on DioException catch (e) {
      throw AddClientRepositoryException(e, 'Network Exception');
    } on ApiException catch (e) {
      throw AddClientRepositoryException(e, 'Clients Api Exception');
    } catch (e) {
      if (e is AddClientRepositoryException) {
        rethrow;
      }
      throw AddClientRepositoryException(e, 'Add client repository Exception');
    }
  }

  @override
  Future<bool> editClient(Client client) async {
    try {
      final EditClientResponse response = await api.updateClient(
          UpdateClientRequest(
              firstname: client.firstname,
              lastname: client.lastname,
              email: client.email,
              address: client.address,
              photo: client.photo,
              caption: client.caption,
              id: client.id));

      if (response is EditClientResponseSuccess) {
        return true;
      }
      throw EditClientRepositoryException(
          editClientFailed: response as EditClientResponseFailed,
          response,
          'Failed to edit client exception');
    } on DioException catch (e) {
      throw EditClientRepositoryException(e, 'Network Exception');
    } on ApiException catch (e) {
      throw EditClientRepositoryException(e, 'Clients Api Exception');
    } catch (e) {
      if (e is EditClientRepositoryException) {
        rethrow;
      }
      throw EditClientRepositoryException(
          e, 'Edit client repository Exception');
    }
  }

  @override
  Future<bool> deleteClient(Client client) async {
    try {
      return await api.deleteClient(client.id);
    } on DioException catch (e) {
      throw DeleteClientRepositoryException(e, 'Network Exception');
    } on ApiException catch (e) {
      throw DeleteClientRepositoryException(e, 'Clients Api Exception');
    } catch (e) {
      throw DeleteClientRepositoryException(
          e, 'Delete client repository Exception');
    }
  }

  Client _mapClientResponseToClient(ClientResponse response) => Client(
      id: response.id,
      firstname: response.firstname,
      lastname: response.lastname,
      email: response.email,
      address: response.address,
      photo: response.photo,
      caption: response.caption);

  ClientsList _getClientsList(
      PostClientResponse response, ClientsList currentClientList) {
    final newClientList = <Client>[];
    final List<Client> mappedClients = response.clients
        .map(_mapClientResponseToClient)
        .toList(growable: false);
    newClientList.addAll(currentClientList.clients);
    newClientList.addAll(mappedClients);
    return ClientsList(
        clients: newClientList,
        nextPage: response.nextPage,
        currentPage: response.current);
  }
}