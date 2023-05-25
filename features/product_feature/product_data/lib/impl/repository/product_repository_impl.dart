import 'package:product_data/product_data.dart';
import 'package:product_domain/product_domain.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(this._productDataSource);

  final ProductDataSource _productDataSource;

  @override
  Future<PaginatedProduct> getPaginatedProduct(int page, String? keyword) {
    return _productDataSource.getPaginatedProduct(page, keyword);
  }

  @override
  Future<Product> getProduct(String productId) {
    return _productDataSource.getProduct(productId);
  }

}
