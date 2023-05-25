import '../repository/invoice_repository.dart';
import '../entity/invoice.dart';

class CreateInvoiceUseCase {
  CreateInvoiceUseCase(this._invoiceRepository);

  final InvoiceRepository _invoiceRepository;

  Future<Invoice> call({
    required int productId,
    required int variantId,
    required String email,
  }) {
    return _invoiceRepository.createInvoice(productId, variantId, email);
  }
}
