import '../repository/invoice_repository.dart';

class SendInvoiceMailUseCase {
  SendInvoiceMailUseCase(this._invoiceRepository);

  final InvoiceRepository _invoiceRepository;

  Future<bool> call({required String invoiceId}) {
    return _invoiceRepository.sendInvoiceMail(invoiceId);
  }
}
