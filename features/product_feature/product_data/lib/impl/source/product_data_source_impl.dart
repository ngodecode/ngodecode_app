import '../../src/model/product_model.dart';
import '../../product_data.dart';

class ProductDataSourceImpl extends ProductDataSource{
  ProductDataSourceImpl(this.productApi);

  final ProductApi productApi;

  @override
  Future<PaginatedProductModel> getPaginatedProduct(int page, String? keyword) {
    return productApi.getPaginatedProducts(page, keyword);
  }

  @override
  Future<ProductModel> getProduct(String productId) {
    return productApi.getProduct(productId);
  }



}