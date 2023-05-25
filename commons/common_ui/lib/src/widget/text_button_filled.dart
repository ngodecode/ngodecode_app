import 'package:flutter/material.dart';
import '../style/common_colors.dart';
import '../style/common_typography.dart';

class TextButtonFilled extends TextButton {
  factory TextButtonFilled.primary(
    String text, {
    Key? key,
    Color? color,
    bool enabled = true,
    required VoidCallback onPressed,
    bool loading = false,
  }) {
    return TextButtonFilled(
      text,
      key: key,
      color: CommonColors.primaryColor,
      onPressed: onPressed,
      enabled: enabled,
      loading: loading,
    );
  }

  factory TextButtonFilled.secondary(
    String text, {
    Key? key,
    Color? color,
    bool enabled = true,
    required VoidCallback onPressed,
    bool loading = false,
  }) {
    return TextButtonFilled(
      text,
      key: key,
      onPressed: onPressed,
      enabled: enabled,
      loading: loading,
    );
  }

  TextButtonFilled(
    String text, {
    Key? key,
    Color color = CommonColors.borderLineColorNormal,
    Color colorDisabled = CommonColors.buttonDisabledColor,
    bool enabled = true,
    required VoidCallback onPressed,
    bool loading = false,
  }) : super(
          key: key,
          onPressed: enabled && !loading ? onPressed : null,
          child: loading
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(),
                )
              : Text(
                  text,
                  style: CommonTypography.textButton.copyWith(
                    color: enabled
                        ? CommonColors.white
                        : CommonColors.textLightColor,
                  ),
                  textAlign: TextAlign.center,
                ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              enabled ? color : colorDisabled,
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
