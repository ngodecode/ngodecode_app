import 'package:common_network/common_network.dart';
import 'package:product_data/src/model/product_model.dart';

class ProductApi extends RestApi {
  ProductApi(super.client);

  Future<PaginatedProductModel> getPaginatedProducts(int page, String? keyword) {
    return get(
      "/product/page/$page",
      queries: {"keyword": keyword},
      factory: PaginatedProductModel.fromJson,
    );
  }

  Future<ProductModel> getProduct(String productId) {
    return get(
      "/product/detail",
      queries: {"productId": productId},
      factory: ProductModel.fromJson,
    );
  }
}
