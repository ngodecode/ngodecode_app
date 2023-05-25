import 'package:common_ui/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:common_ui/number_extension.dart';
import 'package:common_ui/common_style.dart';
import 'package:product_domain/product_domain.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.viewCount,
    required this.likeCount,
    required this.categories,
    required this.ownerName,
    required this.ownerImageUrl,
    this.onTap,
    Key? key,
  }) : super(key: key);

  factory ProductCardWidget.fromProduct({
    required Product product,
    Function()? onTap,
  }) {
    return ProductCardWidget(
      key: Key("key-${product.title}"),
      imageUrl: product.imageUrl.orEmpty(),
      title: product.title.orEmpty(),
      price: product.price.orZero(),
      viewCount: product.viewCount.orZero(),
      likeCount: product.likeCount.orZero(),
      categories: product.categorySummary.orEmpty(),
      ownerName: product.ownerName.orEmpty(),
      ownerImageUrl: product.ownerImageUrl.orEmpty(),
      onTap: onTap,
    );
  }

  final String imageUrl;
  final String title;
  final double price;
  final int viewCount;
  final int likeCount;
  final String categories;
  final String ownerName;
  final String ownerImageUrl;
  final Function()? onTap;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    const radius = 8.0;
    return HoverWidget(builder: (isHovered) {
      return Container(
        decoration: CommonDecorations.boxShadow(radius: radius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            onTap: widget.onTap,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: CommonColors.imageBackground,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: CommonColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: CommonTypography.textBody),
                        const SizedBox(height: 8),
                        _buildBottomInfo(isHovered),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomInfo(bool isHovered) {
    final showViews = !isHovered && !widget.viewCount.isNullOrZero();
    final showLikes = !isHovered && !widget.viewCount.isNullOrZero();
    final showOwner = isHovered;
    final showCategory = !showOwner;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.price.toIDR(),
          style: CommonTypography.textBodyBold,
        ),
        if (showViews) ...[
          const SizedBox(width: 8),
          const Icon(
            Icons.remove_red_eye_outlined,
            color: CommonColors.textLighterColor,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            widget.viewCount.toString(),
            style: CommonTypography.textLight,
          ),
          const SizedBox(width: 8),
        ],
        if (showLikes) ...[
          const Icon(
            Icons.favorite_outline,
            color: CommonColors.textLighterColor,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            widget.viewCount.toString(),
            style: CommonTypography.textLight,
          ),
        ],
        if (showOwner) ...[
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.ownerImageUrl,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, obj, stack) => const Icon(
                    Icons.person_2_rounded,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                widget.ownerName,
                style: CommonTypography.textBodyBold,
              )
            ],
          ),
        ],
        if (showCategory) Text(
          widget.categories,
          style: CommonTypography.textLight,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
