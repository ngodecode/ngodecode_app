import 'package:intl/intl.dart';

extension NumberExtensions on num? {
  String toIDR() {
    final number = this == null
        ? "0"
        : NumberFormat("#,###").format(this!).replaceAll(",", ".");
    return "Rp $number";
  }
}

extension ParseNumberExtensions on String? {
  int toIntOrZero() {
    return this == null ? 0 : (int.tryParse(this!) ?? 0);
  }
  double toDoubleOrZero() {
    return this == null ? 0.0 : (double.tryParse(this!) ?? 0.0);
  }
}
