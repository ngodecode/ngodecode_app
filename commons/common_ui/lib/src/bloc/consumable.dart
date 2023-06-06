extension ConsumableExtension on dynamic {
  Consumable<T> asConsumable<T>() {
    return Consumable(this);
  }
}

class Consumable<T> {
  T? _value;

  Consumable(this._value);

  T? consume() {
    final value = _value;
    if (value != null) {
      _value = null;
    }
    return value;
  }
}
