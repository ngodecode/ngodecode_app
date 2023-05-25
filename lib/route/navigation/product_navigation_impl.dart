import 'package:common_router/common_router.dart';
import 'package:flutter/material.dart';
import 'package:ngodecode_app/route/routes.dart';
import 'package:product_feature/product_feature.dart';

class ProductNavigationImpl implements ProductNavigation {
  ProductNavigationImpl(this._navigator, this._routes);

  final CommonRouteNavigator _navigator;
  final Routes _routes;

  @override
  void navigateToProductList(BuildContext context, String? keyword) {
    _navigator.navigateTo(
      context,
      _routes.product.pathAsUrl(
        query: {
          "keyword": keyword,
        },
      ),
    );
  }

  @override
  void navigateToProductDetail(BuildContext context, int productId) {
    _navigator.navigateTo(
      context,
      _routes.productDetail.pathAsUrl(param: [productId.toString()]),
    );
  }

  @override
  void navigateToPayment(
    BuildContext context,
    int productId,
    int variantId,
    String? imageUrl,
    String? productName,
    String? variantName,
    double? price,
    double? tax,
  ) {
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
  void navigateToSignIn(BuildContext context) {
    _navigator.navigateTo(
      context,
      _routes.login,
    );
  }

  @override
  void navigateToSignUp(BuildContext context) {
    _navigator.navigateTo(
      context,
      _routes.register,
    );
  }
}
