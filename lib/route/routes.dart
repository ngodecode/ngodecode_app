import 'package:payment_feature/payment_feature.dart';
import 'package:product_feature/product_feature.dart';

class Routes implements ProductFeatureRoutePath, PaymentFeatureRoutePath {
  String home = "/product";
  String login = "/";
  String register = "/";

  @override
  String product = "/product";

  @override
  String productDetail = "/product/:productId";

  @override
  String payment = "/payment";

  @override
  String invoiceDetail = "/payment/:invoiceId";

}
