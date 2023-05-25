import 'package:common_ui/common_style.dart';
import 'package:flutter/material.dart';

class ImageUrl extends StatelessWidget {
  const ImageUrl(
    this.url, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.background,
    this.radius,
    this.padding,
  });

  factory ImageUrl.square(
    String url, {
    required double dimension,
    Key? key,
    Color? background,
    double? radius,
    double? padding,
  }) {
    return ImageUrl(
      url,
      key: key,
      width: dimension,
      height: dimension,
      background: background,
      radius: radius,
      padding: padding,
    );
  }

  factory ImageUrl.circle(
    String url, {
    required double dimension,
    Key? key,
    Color? background,
    double? padding,
  }) {
    return ImageUrl(
      url,
      key: key,
      width: dimension,
      height: dimension,
      background: background,
      radius: dimension / 2,
      padding: padding,
    );
  }

  final double width;
  final double height;
  final String url;
  final Color? background;
  final double? radius;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 4),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding ?? 0),
        color: background ?? CommonColors.imageBackground,
        child: Image.network(
          url,
          loadingBuilder: (context, image, progress) {
            if (progress == null) {
              return image;
            }
            return const Center(
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorBuilder: (context, object, stack) {
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
