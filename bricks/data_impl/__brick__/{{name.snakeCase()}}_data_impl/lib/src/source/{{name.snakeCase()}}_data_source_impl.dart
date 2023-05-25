import 'package:{{name.snakeCase()}}_data/{{name.snakeCase()}}_data.dart';

class {{name.pascalCase()}}DataSourceImpl{

  {{name.pascalCase()}}DataSourceImpl(this._{{name.camelCase()}}Api);

  final {{name.pascalCase()}}Api _{{name.camelCase()}}Api;

  Future<List<{{name.pascalCase()}}Model>> get{{name.pascalCase()}}List(){
    return _{{name.camelCase()}}Api.get{{name.pascalCase()}}List();
  }

  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}(){
    return _{{name.camelCase()}}Api.get{{name.pascalCase()}}();
  }

  Future<Paginated{{name.pascalCase()}}Model> getPaginated{{name.pascalCase()}}(int page){
    return _{{name.camelCase()}}Api.getPaginated{{name.pascalCase()}}(page);
  }

}