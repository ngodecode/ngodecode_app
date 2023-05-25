import 'package:product_domain/product_domain.dart';
import 'package:common_data/src/model_mapper.dart';

class ProductModel extends Product {
  ProductModel({
    super.productId,
    super.title,
    super.description,
    super.imageUrl,
    super.price,
    super.likeCount,
    super.viewCount,
    super.categories,
    super.categorySummary,
    super.ownerName,
    super.ownerImageUrl,
    super.ownerProfileUrl,
    super.demoLinks,
    super.devTools,
    super.features,
    super.whatInside,
    super.previewFiles,
    super.variants,
    super.file,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'];
    final owner = json.getJson('owner');
    return ProductModel(
      productId: json['id'],
      title: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      price: json['price'],
      likeCount: json['like_count'],
      viewCount: json['view_count'],
      categories: categories is List
          ? categories.mapAs((item) => CategoryModel(item))
          : List.empty(),
      categorySummary: categories is String ? categories : null,
      ownerName: owner.get('name') ?? json['owner_name'],
      ownerImageUrl: owner.get('image_url') ?? json['owner_image_url'],
      ownerProfileUrl: owner.get('profile') ?? json['owner_profile_url'],
      demoLinks: json['demo_links'],
      devTools: json['dev_tools'],
      features: json['features'],
      whatInside: json['what_inside'],
      previewFiles: json['preview_files'],
      file: json['file'],
      variants: (json['variants'] as List?).mapAs(
        (item) => ProductVariantModel(item),
      ),
    );
  }
}

class ProductVariantModel extends ProductVariant {
  ProductVariantModel(Map<String, dynamic> json)
      : super(
          id: json['id'],
          title: json['title'],
          imageUrl: json['image_url'],
          file: json['file'],
          price: json['price'],
        );
}

class CategoryModel extends Category {
  CategoryModel(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
          imageUrl: json['icon_url'],
        );
}

class PaginatedProductModel extends PaginatedProduct {
  PaginatedProductModel({
    super.page,
    super.totalPage,
    super.products,
  });

  factory PaginatedProductModel.fromJson(Map<String, dynamic> json) {
    return PaginatedProductModel(
      page: json['page'],
      totalPage: json['total_page'],
      products:
          (json['products'] as List?).mapAs((p0) => ProductModel.fromJson(p0)),
    );
  }
}
