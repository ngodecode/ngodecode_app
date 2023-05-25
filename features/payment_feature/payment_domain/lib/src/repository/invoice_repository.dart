import '../entity/invoice.dart';

abstract class InvoiceRepository{

  Future<Invoice> createInvoice(int productId, int variantId, String email);

  Future<bool> sendInvoiceMail(String invoiceId);

  Future<Invoice> getInvoice(String invoiceId);

}