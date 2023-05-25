import 'package:common_network/common_network.dart';
import '../model/invoice_model.dart';

class PaymentApi extends RestApi {
  PaymentApi(super.client);

  Future<InvoiceModel> createInvoice(
    int productId,
    int variantId,
    String email,
  ) {
    return post(
      "/invoice/create",
      body: {
        "product_id": productId,
        "variant_id": variantId,
        "email": email,
      },
      factory: InvoiceModel.fromJson,
    );
  }

  Future<InvoiceMailModel> getInvoiceMail(String invoiceId) {
    return get(
      "/invoice/email/$invoiceId",
      factory: InvoiceMailModel.fromJson,
    );
  }

  Future<InvoiceModel> getInvoice(String invoiceId) {
    return get(
      "/invoice/verify/$invoiceId",
      factory: InvoiceModel.fromJson,
    );
  }
}
