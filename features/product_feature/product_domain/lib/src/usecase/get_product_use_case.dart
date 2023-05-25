import '../repository/product_repository.dart';
import '../entity/product.dart';

class GetProductUseCase{

  GetProductUseCase(this._productRepository);

  final ProductRepository _productRepository;

  Future<Product> call({required String productId}){
    return _productRepository.getProduct(productId);
  }

}