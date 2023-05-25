import 'package:common_router/common_router.dart';
import 'package:flutter/material.dart';
import 'package:ngodecode_app/route/routes.dart';
import 'package:payment_feature/payment_feature.dart';

class PaymentNavigationImpl extends PaymentNavigation {
  PaymentNavigationImpl(this._navigator, this._routes);

  final CommonRouteNavigator _navigator;
  final Routes _routes;

  @override
  void navigateToPayment(
    BuildContext context, {
    required int productId,
    required int variantId,
    String? imageUrl,
    String? productName,
    String? variantName,
    double? price,
    double? tax,
  }) {
    _navigator.navigateTo(
      context,
      _routes.payment.pathAsUrl(query: {
        "productId": productId,
        "variantId": variantId,
        "imageUrl": imageUrl,
        "productName": productName,
        "variantName": variantName,
        "price": price,
        "tax": tax,
      }),
    );
  }

  @override
  void navigateToPaymentInvoice(
    BuildContext context, {
    required String invoiceId,
  }) {
    _navigator.navigateTo(
      context,
      _routes.invoiceDetail.pathAsUrl(param: [invoiceId]),
    );
  }
}
