import 'rest_client.dart';

typedef ModelFactory<T> = T Function(Map<String, dynamic>);

abstract class RestApi {
  RestApi(this.client);

  final RestClient client;

  Future<T> _request<T>(
    String method,
    String path, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
    Object? body,
    required ModelFactory<T> factory,
  }) {
    return client<T>(
      Request(
        method: method,
        path: path,
        queries: queries?..removeWhere((key, value) => value == null),
        headers: headers?..removeWhere((key, value) => value == null),
        body: body,
      ),
      factory,
    );
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
    required ModelFactory<T> factory,
  }) async {
    return _request(
      "GET",
      path,
      queries: queries,
      headers: headers,
      factory: factory,
    );
  }

  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
    dynamic body,
    required ModelFactory<T> factory,
  }) async {
    return _request(
      "POST",
      path,
      queries: queries,
      headers: headers,
      body: body,
      factory: factory,
    );
  }

}
