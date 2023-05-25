import 'package:payment_data/payment_data.dart';
import 'package:payment_domain/payment_domain.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  InvoiceRepositoryImpl(this._invoiceDataSource);

  InvoiceDataSource _invoiceDataSource;

  @override
  Future<Invoice> createInvoice(int productId, int variantId, String email) {
    return _invoiceDataSource.createInvoice(productId, variantId, email);
  }

  @override
  Future<bool> sendInvoiceMail(String invoiceId) {
    return _invoiceDataSource
        .getInvoiceMail(invoiceId)
        .then((value) => value.success == true);
  }

  @override
  Future<Invoice> getInvoice(String invoiceId) {
    return _invoiceDataSource.getInvoice(invoiceId);
  }
}
