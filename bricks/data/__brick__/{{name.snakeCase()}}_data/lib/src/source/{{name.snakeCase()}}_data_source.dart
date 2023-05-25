import '../model/{{name.snakeCase()}}_model.dart';

abstract class {{name.pascalCase()}}DataSource {

  Future<List<{{name.pascalCase()}}Model>> get{{name.pascalCase()}}List();

  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}();

  Future<Paginated{{name.pascalCase()}}Model> getPaginated{{name.pascalCase()}}(int page);

}