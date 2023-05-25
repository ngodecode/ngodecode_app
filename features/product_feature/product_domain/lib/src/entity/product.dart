class Product {
  Product({
    this.productId,
    this.title,
    this.imageUrl,
    this.price,
    this.likeCount,
    this.viewCount,
    this.categories,
    this.categorySummary,
    this.ownerName,
    this.ownerImageUrl,
    this.ownerProfileUrl,
    this.demoLinks,
    this.devTools,
    this.features,
    this.whatInside,
    this.previewFiles,
    this.description,
    this.variants,
    this.file,
  });

  Product copyWith({
    final int? productId,
    final String? title,
    final String? imageUrl,
    final double? price,
    final int? likeCount,
    final int? viewCount,
    final List<Category>? categories,
    final String? categorySummary,
    final String? ownerName,
    final String? ownerImageUrl,
    final String? ownerProfileUrl,
    final String? demoLinks,
    final String? devTools,
    final String? features,
    final String? whatInside,
    final String? previewFiles,
    final String? description,
    final List<ProductVariant>? variants,
    final String? file,
  }) {
    return Product(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      likeCount: likeCount ?? this.likeCount,
      viewCount: viewCount ?? this.viewCount,
      categories: categories ?? this.categories,
      categorySummary: categorySummary ?? this.categorySummary,
      ownerName: ownerName ?? this.ownerName,
      ownerImageUrl: ownerImageUrl ?? this.ownerImageUrl,
      ownerProfileUrl: ownerProfileUrl ?? this.ownerProfileUrl,
      demoLinks: demoLinks ?? this.demoLinks,
      devTools: devTools ?? this.devTools,
      features: features ?? this.features,
      whatInside: whatInside ?? this.whatInside,
      previewFiles: previewFiles ?? this.previewFiles,
      description: description ?? this.description,
      variants: variants ?? this.variants,
      file: file ?? this.file,
    );
  }

  final int? productId;

  final String? title;

  final String? imageUrl;

  final double? price;

  final int? likeCount;
  final int? viewCount;
  final List<Category>? categories;
  final String? categorySummary;

  final String? ownerName;

  final String? ownerImageUrl;

  final String? ownerProfileUrl;

  final String? demoLinks;

  final String? devTools;

  final String? features;

  final String? whatInside;

  final String? previewFiles;

  final String? description;

  final List<ProductVariant>? variants;

  final String? file;
}

class ProductVariant {
  ProductVariant({this.id, this.imageUrl, this.title, this.price, this.file});

  final int? id;
  final String? imageUrl;
  final String? title;
  final double? price;
  final String? file;
}

class PaginatedProduct {
  int? page;
  int? totalPage;
  List<Product>? products;

  PaginatedProduct({
    this.page,
    this.totalPage,
    this.products,
  });
}

class Category {
  int? id;
  String? name;
  String? imageUrl;

  Category({
    this.id,
    this.name,
    this.imageUrl,
  });
}
