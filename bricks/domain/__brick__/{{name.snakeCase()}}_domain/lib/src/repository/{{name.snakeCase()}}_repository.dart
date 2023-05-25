import '../entity/{{name.snakeCase()}}.dart';

abstract class {{name.pascalCase()}}Repository{

  Future<List<{{name.pascalCase()}}>> get{{name.pascalCase()}}List();

  Future<{{name.pascalCase()}}> get{{name.pascalCase()}}();

  Future<Paginated{{name.pascalCase()}}> getPaginated{{name.pascalCase()}}(int page);

}