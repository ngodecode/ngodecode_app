import 'package:payment_domain/payment_domain.dart';

class GetInvoiceDetailUseCase {

  GetInvoiceDetailUseCase(this._repository);

  final InvoiceRepository _repository;

  Future<Invoice> call({required String id}) {
    return _repository.getInvoice(id);
  }

}