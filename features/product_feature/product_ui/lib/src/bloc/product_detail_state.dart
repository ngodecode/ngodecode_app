import 'package:common_ui/nullable_extension.dart';
import 'package:product_domain/product_domain.dart';

class ProductDetailState {
  ProductDetailState({
    this.isLoading,
    this.product,
    this.variantId,
  });

  final bool? isLoading;
  final Product? product;
  final int? variantId;

  ProductVariant? get selectedVariant {
    return product?.variants.firstWhereOrNull(
      (element) => element.id == variantId,
    );
  }

  String get title {
    return "${product?.title} ${selectedVariant?.title}";
  }

  String? get imageUrl {
    return selectedVariant?.imageUrl ?? product?.imageUrl;
  }

  double? get price {
    return selectedVariant?.price ?? product?.price;
  }

  ProductDetailState copyWith({
    final bool? isLoading,
    final Product? product,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
    );
  }
}
