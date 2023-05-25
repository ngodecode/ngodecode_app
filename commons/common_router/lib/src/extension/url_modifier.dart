extension UrlModifier on String {
  String pathAsUrl({List<String>? param, Map<String, dynamic>? query}) {
    if (param == null) return this;
    var path = "";
    final urls = split("/");
    for(var str in urls) {
      if (str.isEmpty){
        continue;
      }
      if (!str.startsWith(":")) {
        path += "/$str";
      }
      else {
        path += "/${param.removeAt(0)}";
      }
    }
    query?.forEach((key, value) {
      if (!path.contains("?")){
        path += "?";
      }
      else {
        path += "&";
      }
      path += "$key=$value";
    });
    return path;
  }

}