abstract class ProductDetailEvent {}

class Load extends ProductDetailEvent {
  Load({required this.productId, this.variantId = 0});

  final String productId;
  final int? variantId;
}

class SelectVariant extends ProductDetailEvent {
  SelectVariant({required this.id});

  final int id;
}

enum BuyMethod { instant, saveToAccount }

class SubmitBuy extends ProductDetailEvent {
  SubmitBuy({required this.method, this.email});

  final BuyMethod method;
  final String? email;
}
