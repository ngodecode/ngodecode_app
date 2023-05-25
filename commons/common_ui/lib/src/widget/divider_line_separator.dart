import 'package:flutter/material.dart';
import '../style/common_colors.dart';

class DividerLineSeparator extends Divider {
  const DividerLineSeparator({Key? key})
      : super(
          key: key,
          color: CommonColors.separatorLineColor,
          height: 1,
        );

}
