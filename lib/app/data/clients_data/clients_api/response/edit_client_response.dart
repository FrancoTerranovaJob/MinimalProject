import 'package:minimal/app/data/clients_data/clients_api/response/client_response.dart';

abstract class EditClientResponse {}

class EditClientResponseSuccess implements EditClientResponse {
  final ClientResponse clientResponse;
  factory EditClientResponseSuccess.fromJson(Map<String, dynamic> json) {
    return EditClientResponseSuccess(
        clientResponse: ClientResponse.fromJson(json));
  }

  EditClientResponseSuccess({required this.clientResponse});
}

class EditClientResponseFailed implements EditClientResponse {
  final int errorNumber;
  final String message;

  const EditClientResponseFailed(this.errorNumber, this.message);

  factory EditClientResponseFailed.fromJson(Map<String, dynamic> json) {
    return EditClientResponseFailed(json['code'], '');
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