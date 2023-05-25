import '../entity/product.dart';

abstract class ProductRepository{

  Future<Product> getProduct(String productId);

  Future<PaginatedProduct> getPaginatedProduct(int page, String? keyword);

}