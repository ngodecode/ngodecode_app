extension NullIntExtension on int? {
  int orZero() => this == null ? 0 : this!;

  bool isNullOrZero() => this == null || this == 0;
}

extension NullDoubleExtension on double? {
  double orZero() => this == null ? 0 : this!;

  bool isNullOrZero() => this == null || this == 0;
}

extension NullStringExtension on String? {
  String orEmpty() => this == null ? "" : this!;

  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension NullListExtension<T> on List<T>? {

  List<T> orEmpty() => this == null ? List.empty() : this!;

  bool isNullOrEmpty() => this == null || this!.isEmpty;

  T? firstOrNull() => isNullOrEmpty() ? null : this!.first;

  T? firstWhereOrNull(bool Function(T element) test) {
    final elements = this;
    if (elements != null) {
      for (var element in elements) {
        if (test(element)) return element;
      }
    }
    return null;
  }

}
extension NullBoolExtension on bool? {

  bool orFalse() => this == null ? false : this!;
  bool orTrue() => this == null ? true : this!;

}





