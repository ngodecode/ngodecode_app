extension ListModelMapper on List? {
  List<T> mapAs<T>(T Function(dynamic) mapper) {
    return this?.map((e) => mapper(e)).toList() ?? List.empty();
  }
}

extension JsonModelMapper on Map? {
  dynamic get(String key) {
    return this?.containsKey(key) == true ? this![key] : null;
  }

  Map<String, dynamic>? getJson(String key) {
    return get(key);
  }
}