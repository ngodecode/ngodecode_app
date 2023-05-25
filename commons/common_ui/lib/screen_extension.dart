import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  double matchWidth({double percent = 1}) =>
      MediaQuery.of(this).size.width * percent;

  double matchHeight({double percent = 1}) =>
      MediaQuery.of(this).size.height * percent;
}
