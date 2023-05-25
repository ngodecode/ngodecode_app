import '../model/invoice_model.dart';

abstract class InvoiceDataSource {
  Future<InvoiceModel> createInvoice(
    int productId,
    int variantId,
    String email,
  );

  Future<InvoiceMailModel> getInvoiceMail(String invoiceId);

  Future<InvoiceModel> getInvoice(String invoiceId);
}
