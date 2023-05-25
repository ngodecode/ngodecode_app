import '../model/product_model.dart';

abstract class ProductDataSource {

  Future<ProductModel> getProduct(String productId);

  Future<PaginatedProductModel> getPaginatedProduct(int page, String? keyword);

}