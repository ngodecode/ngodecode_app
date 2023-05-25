import 'package:{{name.snakeCase()}}_data/{{name.snakeCase()}}_data.dart';
import 'package:{{name.snakeCase()}}_domain/{{name.snakeCase()}}_domain.dart';

class {{name.pascalCase()}}RepositoryImpl extends {{name.pascalCase()}}Repository {

  final {{name.pascalCase()}}DataSource _{{name.camelCase()}}DataSource;

  Future<List<{{name.pascalCase()}}>> get{{name.pascalCase()}}List(){
    return _{{name.camelCase()}}DataSource.get{{name.pascalCase()}}List();
  }

  Future<{{name.pascalCase()}}> get{{name.pascalCase()}}(){
    return _{{name.camelCase()}}DataSource.get{{name.pascalCase()}}();
  }

  Future<Paginated{{name.pascalCase()}}> getPaginated{{name.pascalCase()}}(int page){
    return Future.error(Exception("Not Implemented"));
  }

}