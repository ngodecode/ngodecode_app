import '../repository/product_repository.dart';
import '../entity/product.dart';

class GetProductPaginatedUseCase{

  GetProductPaginatedUseCase(this._productRepository);

  final ProductRepository _productRepository;

  Future<PaginatedProduct> call({required int page, String? keyword}){
    return _productRepository.getPaginatedProduct(page, keyword);
  }

}