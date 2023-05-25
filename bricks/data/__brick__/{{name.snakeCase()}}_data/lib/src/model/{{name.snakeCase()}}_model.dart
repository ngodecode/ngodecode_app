import 'package:{{name.snakeCase()}}_domain/{{name.snakeCase()}}_domain.dart';

class {{name.pascalCase()}}Model extends {{name.pascalCase()}} {

  {{name.pascalCase()}}Model():super();

  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) {
    return _${{name.pascalCase()}}ModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _${{name.pascalCase()}}ModelToJson(this);

}

class Paginated{{name.pascalCase()}}Model {

  Paginated{{name.pascalCase()}}Model(this.page);

  final int page;

  factory Paginated{{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) {
    return _$Paginated{{name.pascalCase()}}ModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$Paginated{{name.pascalCase()}}ModelToJson(this);

}
