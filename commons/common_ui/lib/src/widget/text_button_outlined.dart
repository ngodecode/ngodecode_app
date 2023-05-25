import 'package:flutter/material.dart';
import '../style/common_colors.dart';
import '../style/common_typography.dart';

class TextButtonOutlined extends TextButton {

  factory TextButtonOutlined.primarySmall(
      String text, {
        Key? key,
        required VoidCallback onPressed,
      }) {
    return TextButtonOutlined(
      text,
      key: key,
      onPressed: onPressed,
      textColor: CommonColors.buttonOutlinedColorPrimary,
      borderColor: CommonColors.buttonOutlinedColorPrimary,
      textSize: CommonTypography.textButtonSizeSmall,
    );
  }

  factory TextButtonOutlined.primary(
    String text, {
    Key? key,
    required VoidCallback onPressed,
  }) {
    return TextButtonOutlined(
      text,
      key: key,
      onPressed: onPressed,
      textColor: CommonColors.buttonOutlinedColorPrimary,
      borderColor: CommonColors.buttonOutlinedColorPrimary,
    );
  }

  factory TextButtonOutlined.secondary(
      String text, {
        Key? key,
        Color? color,
        required VoidCallback onPressed,
      }) {
    return TextButtonOutlined(
      text,
      key: key,
      onPressed: onPressed,
      textColor: CommonColors.textBodyColor,
    );
  }

  TextButtonOutlined(
    String text, {
    Key? key,
    Color textColor = CommonColors.borderLineColorNormal,
    Color borderColor = CommonColors.borderLineColorNormal,
    double? textSize = CommonTypography.textButtonSize,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: Text(
            text,
            style: CommonTypography.textButton.copyWith(
              color: textColor,
              fontSize: textSize,
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  CommonTypography.buttonCornerRadius,
                ),
                side: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
            fixedSize: MaterialStateProperty.all(const Size.fromHeight(
              CommonTypography.buttonHeight,
            )),
            padding: MaterialStateProperty.all(const EdgeInsets.all(
              CommonTypography.buttonPadding,
            )),
          ),
        );
}
