import '../src/api/payment_api.dart';
import '../src/model/invoice_model.dart';
import '../src/source/invoice_data_source.dart';

class InvoiceDataSourceImpl extends InvoiceDataSource {
  InvoiceDataSourceImpl(this._paymentApi);

  PaymentApi _paymentApi;

  @override
  Future<InvoiceModel> createInvoice(
    int productId,
    int variantId,
    String email,
  ) {
    return _paymentApi.createInvoice(productId, variantId, email);
  }

  @override
  Future<InvoiceMailModel> getInvoiceMail(String invoiceId) {
    return _paymentApi.getInvoiceMail(invoiceId);
  }

  @override
  Future<InvoiceModel> getInvoice(String invoiceId) {
    return _paymentApi.getInvoice(invoiceId);
  }
}
