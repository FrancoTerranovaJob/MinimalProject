import 'package:equatable/equatable.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/client_response.dart';

abstract class AddClientResponse {}

class AddClientSuccessResponse extends Equatable implements AddClientResponse {
  final ClientResponse clientResponse;

  AddClientSuccessResponse(this.clientResponse);

  factory AddClientSuccessResponse.fromJson(Map<String, dynamic> json) {
    return AddClientSuccessResponse(ClientResponse.fromJson(json));
  }
  @override
  List<Object> get props => [clientResponse];
}

class AddClientFailedResponse extends Equatable implements AddClientResponse {
  final int errorNumber;
  final String message;

  const AddClientFailedResponse(this.errorNumber, this.message);

  factory AddClientFailedResponse.fromJson(Map<String, dynamic> json) {
    return AddClientFailedResponse(json['code'], '');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = errorNumber;
    data['message'] = message;

    return data;
  }

  @override
  List<Object> get props => [errorNumber, message];
}