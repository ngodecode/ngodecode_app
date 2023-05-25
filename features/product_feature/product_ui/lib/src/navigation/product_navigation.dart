import 'package:flutter/cupertino.dart';

abstract class ProductNavigation {
  void navigateToProductList(BuildContext context, String? keyword);

  void navigateToProductDetail(BuildContext context, int productId);

  void navigateToSignIn(BuildContext context);

  void navigateToSignUp(BuildContext context);

  void navigateToPayment(
    BuildContext context,
    int productId,
    int variantId,
    String? imageUrl,
    String? productName,
    String? variantName,
    double? price,
    double? tax,
  );
}
