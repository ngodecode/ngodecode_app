import 'package:flutter/material.dart';
import '../style/common_colors.dart';

class CommonTypography {
  static const textBodySize = 14.0;
  static const textHeadingSize = 16.0;
  static const textHeading2Size = 24.0;
  static const textButtonSize = 16.0;
  static const textButtonSizeSmall = 14.0;

  static const buttonHeight = 42.0;
  static const buttonPadding = 16.0;
  static const buttonCornerRadius = 8.0;

  static const textHeading = TextStyle(
    fontSize: textHeadingSize,
    color: CommonColors.textBodyColor,
    fontWeight: FontWeight.bold,
  );
  static const textHeading2 = TextStyle(
    fontSize: textHeading2Size,
    color: CommonColors.textBodyColor,
    fontWeight: FontWeight.bold,
  );
  static const textBody = TextStyle(
    fontSize: textBodySize,
    color: CommonColors.textBodyColor,
    height: 1.5,
  );
  static const textLink = TextStyle(
    fontSize: textBodySize,
    color: CommonColors.textLinkColor,
    height: 1.5,
  );
  static const textBodyBold = TextStyle(
    fontSize: textBodySize,
    color: CommonColors.textBodyColor,
    fontWeight: FontWeight.bold,
  );
  static const textLight = TextStyle(
    fontSize: textBodySize,
    color: CommonColors.textLightColor,
  );
  static const textLightBold = TextStyle(
    fontSize: textBodySize,
    color: CommonColors.textLightColor,
    fontWeight: FontWeight.bold,
  );
  static const textButton = TextStyle(
    fontSize: textButtonSize,
    color: CommonColors.textBodyColor,
    fontWeight: FontWeight.normal,
  );
  static const textButtonLink = TextStyle(
    fontSize: textButtonSize,
    color: CommonColors.textLinkColor,
    fontWeight: FontWeight.normal,
  );
}
