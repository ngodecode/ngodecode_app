import 'package:flutter/material.dart';

abstract class PaymentNavigation {
  void navigateToPayment(
    BuildContext context, {
    required int productId,
    required int variantId,
    String? imageUrl,
    String? productName,
    String? variantName,
    double? price,
    double? tax,
  });

  void navigateToPaymentInvoice(
    BuildContext context, {
    required String invoiceId,
  });
}
