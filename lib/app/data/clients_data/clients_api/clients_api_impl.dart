import 'package:dio/dio.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api.dart';
import 'package:minimal/app/data/clients_data/clients_api/clients_api_impl.dart';
import 'package:minimal/app/data/clients_data/clients_api/exceptions/client_api_exceptions.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/create_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/post_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/request/update_client_request.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/client_response.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/post_client_response.dart';
import 'package:minimal/app/data/secure_storage/secure_storage.dart';
import 'package:minimal/di/get_it.dart';

class ClientsApiImpl extends ClientsApi {
  final http = services.get<Dio>();
  final secureStorage = services.get<SecureStorage>();
  static const String clientPath = '/client';

  @override
  Future<PostClientResponse> getClients(
      PostClientRequest postClientRequest) async {
    try {
      http.options.headers.addAll(await _getAuthorizationHeader());
      final response = await http.post('$clientPath/list',
          queryParameters: {'page': postClientRequest.pageNumber},
          data: postClientRequest.toJson());
      final clientData = response.data;
      return PostClientResponse.fromJson(clientData['response']);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw GetClientException(e, 'Getting client exception');
    }
  }

  @override
  Future<ClientResponse> addClient(CreateClientRequest clientRequest) async {
    try {
      http.options.headers.addAll(await _getAuthorizationHeader());
      final response =
          await http.post('$clientPath/save', data: clientRequest.toJson());
      final clientData = response.data;
      return ClientResponse.fromJson(clientData['response']);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw AddClientException(e, 'Adding client exception');
    }
  }

  @override
  Future<bool> deleteClient(int clientId) async {
    try {
      http.options.headers.addAll(await _getAuthorizationHeader());
      final response = await http.delete('$clientPath/remove/$clientId');
      final deleteData = response.data;

      return deleteData['success'] == true;
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw DeleteClientException(e, 'Deleting client exception');
    }
  }

  @override
  Future<ClientResponse> updateClient(
      UpdateClientRequest updateClientRequest) async {
    try {
      http.options.headers.addAll(await _getAuthorizationHeader());
      final response = await http.post('$clientPath/save',
          data: updateClientRequest.toJson());
      final updatedUser = response.data;
      return ClientResponse.fromJson(updatedUser['response']);
    } on DioError catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw UpdateClientException(e, 'Updating client exception');
    }
  }

  Future<Map<String, String>> _getAuthorizationHeader() async {
    final session = await secureStorage.getSession();
    final sessionToken = session!.accessToken;
    final sessionTokenType = session.tokenType;
    return {'Authorization': '$sessionTokenType $sessionToken'};
  }

  DioException _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.response:
        return DioException(error, 'Dio response exception');

      case DioErrorType.connectTimeout:
        return DioException(error, 'Dio connection timeout exception');

      case DioErrorType.sendTimeout:
        return DioException(error, 'Dio connection send timeout exception');
      case DioErrorType.receiveTimeout:
        return DioException(error, 'Dio connection receive timeout exception');

      case DioErrorType.cancel:
        return DioException(error, 'Dio cancel exception');

      case DioErrorType.other:
        return DioException(error, 'Dio unknown exception');
    }
  }
}