import '../repository/{{name.snakeCase()}}_repository.dart';
import '../entity/{{name.snakeCase()}}.dart';

class {{name.pascalCase()}}UseCase{

  {{name.pascalCase()}}UseCase(this._{{name.camelCase()}}Repository);

  final {{name.pascalCase()}}Repository _{{name.camelCase()}}Repository;

  Future<Paginated{{name.pascalCase()}}> call({required int page}){
    return _{{name.camelCase()}}Repository.getPaginated{{name.pascalCase()}}(page);
  }

}