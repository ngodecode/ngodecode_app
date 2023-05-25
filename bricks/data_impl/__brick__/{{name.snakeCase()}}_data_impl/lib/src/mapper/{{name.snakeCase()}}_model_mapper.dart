import 'package:{{name.snakeCase()}}_data/{{name.snakeCase()}}_data.dart';
import 'package:{{name.snakeCase()}}_domain/{{name.snakeCase()}}_domain.dart';

extension {{name.pascalCase()}}ModelsMapper on {{name.pascalCase()}}Model {
  {{name.pascalCase()}} as{{name.pascalCase()}}() {
    return this;
  }
}