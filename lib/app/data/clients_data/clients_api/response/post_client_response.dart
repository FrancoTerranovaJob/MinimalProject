import 'package:equatable/equatable.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/client_response.dart';

class PostClientResponse extends Equatable {
  final List<ClientResponse> clients;
  final String? nextPage;
  final int current;

  const PostClientResponse(
      {required this.clients, required this.nextPage, required this.current});

  factory PostClientResponse.fromJson(Map<String, dynamic> json) {
    final clientData = List<Map<String, dynamic>>.from(json['data']);

    return PostClientResponse(
        clients: clientData
            .map((client) => ClientResponse.fromJson(client))
            .toList(),
        nextPage: json['next_page_url'],
        current: json['current_page']);
  }

  @override
  List<Object?> get props => [clients, nextPage, current];
}