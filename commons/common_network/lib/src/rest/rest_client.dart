class Request {
  Request({
    required this.method,
    required this.path,
    this.queries,
    this.headers,
    this.extras,
    this.body,
  });

  String method;
  String path;
  Object? body;
  Map<String, dynamic>? queries;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? extras;
}

abstract class RestClient {
  Future<T> call<T>(Request request, Function(Map<String, dynamic>) factory);
}
