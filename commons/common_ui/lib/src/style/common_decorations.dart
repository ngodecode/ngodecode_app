import 'package:flutter/material.dart';
import '../style/common_colors.dart';

class CommonDecorations {
  static boxOutlined({
    radius = 18,
    borderColor = CommonColors.separatorLineColor,
    Color? color,
  }) {
    return BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: color,
    );
  }

  static boxShadow({double radius = 12}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 0.2,
          blurRadius: 0.5,
        ),
      ],
    );
  }

  static inputField({
    String? hint,
    double radius = 6,
    Color borderColor = CommonColors.borderLineColorNormal,
    Color focusedColor = CommonColors.borderLineColorFocused,
    Color errorColor = CommonColors.borderLineColorError,
    String? errorText,
  }) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: focusedColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: errorColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: errorColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      errorText: errorText,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    );
  }
}
