import 'package:product_domain/product_domain.dart';

class ProductListState {
  ProductListState({
    this.page,
    this.isLoading,
    this.isLoadingMore,
    this.hasMore,
    this.products,
    this.keyword,
  });

  final List<Product>? products;
  final int? page;
  final String? keyword;
  final bool? isLoading;
  final bool? isLoadingMore;
  final bool? hasMore;

  ProductListState copyWith({
    final List<Product>? products,
    final int? page,
    final String? keyword,
    final bool? isLoading,
    final bool? isLoadingMore,
    final bool? hasMore,
  }) {
    return ProductListState(
      products: products ?? this.products,
      page: page ?? this.page,
      keyword: keyword ?? this.keyword,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
