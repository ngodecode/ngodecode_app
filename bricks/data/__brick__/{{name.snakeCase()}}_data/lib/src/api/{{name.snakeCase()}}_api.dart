import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../model/{{name.snakeCase()}}_model.dart';

part '{{name.snakeCase()}}_api.g.dart';

@RestApi()
abstract class {{name.pascalCase()}}Api {

  factory {{name.pascalCase()}}Api(Dio dio) = _{{name.pascalCase()}}Api;

  @GET("/{{name.snakeCase()}}/item")
  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}();

  @GET("/{{name.snakeCase()}}/list")
  Future<List<{{name.pascalCase()}}Model>> get{{name.pascalCase()}}List();

  @GET("/{{name.snakeCase()}}/paginated")
  Future<Paginated{{name.pascalCase()}}Model> getProductDetail(@Query("page") int page);

}