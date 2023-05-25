import 'dart:convert';
import 'dart:io';

import 'package:common_network/common_network.dart';
import 'package:dio/dio.dart';

final dioLoggerInterceptor = InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });

  print("┌------------------------------------------------------------------------------");
  print('''| [DIO] Request: ${options.method} ${options.uri}
| ${options.data.toString()}
| Headers:\n$headers''');
  print("├------------------------------------------------------------------------------");
  handler.next(options);  //continue
}, onResponse: (Response response, handler) async {
  print("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
  print("└------------------------------------------------------------------------------");
  handler.next(response);
  // return response; // continue
}, onError: (DioError error, handler) async {
  print("| [DIO] Error: ${error.error}: ${error.response.toString()}");
  print("└------------------------------------------------------------------------------");
  handler.next(error); //continue
});

class DioRestClient extends RestClient {
  DioRestClient(String baseUrl) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
      sendTimeout: 60 * 1000,
    ));
    _dio.interceptors.add(dioLoggerInterceptor);
  }

  late final Dio _dio;

  @override
  Future<T> call<T>(Request request, ModelFactory factory) async {
    final options = Options(
      method: request.method,
      headers: request.headers,
      extra: request.extras,
      responseType: ResponseType.json,
    );

    if (T is List) {
      final result = await _dio.request<List<dynamic>>(
        request.path,
        queryParameters: request.queries,
        data: request.body,
        options: options,
      );
      return result.data?.map((e) => factory(e)).toList() as T;
    } else {
      final result = await _dio.request<Map<String, dynamic>>(
        request.path,
        queryParameters: request.queries,
        data: request.body,
        options: options,
      );
      return factory(result.data ?? {});
    }
  }
}
