import '../repository/{{name.snakeCase()}}_repository.dart';
import '../entity/{{name.snakeCase()}}.dart';

class {{name.pascalCase()}}ListUseCase{

  {{name.pascalCase()}}ListUseCase(this._{{name.camelCase()}}Repository);

  final {{name.pascalCase()}}Repository _{{name.camelCase()}}Repository;

  Future<List<{{name.pascalCase()}}>> call(){
    return _{{name.camelCase()}}Repository.get{{name.pascalCase()}}List();
  }

}