import 'package:minimal/app/common/exceptions/domain_exception.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/add_client_response.dart';
import 'package:minimal/app/data/clients_data/clients_api/response/edit_client_response.dart';

class AddClientRepositoryException extends DomainException {
  AddClientFailedResponse? addClientFailedResponse;

  AddClientRepositoryException(
    super.error,
    super.message, {
    this.addClientFailedResponse,
  });
}

class GetClientsRepositoryException extends DomainException {
  GetClientsRepositoryException(super.error, super.message);
}

class EditClientRepositoryException extends DomainException {
  EditClientResponseFailed? editClientFailed;
  EditClientRepositoryException(
    super.error,
    super.message, {
    this.editClientFailed,
  });
}

class DeleteClientRepositoryException extends DomainException {
  DeleteClientRepositoryException(super.error, super.message);
}