class {{name.pascalCase()}} {

  // TODO: add fields here
  final int id;

  {{name.pascalCase()}}({
    required this.id,
  });

}


class Paginated{{name.pascalCase()}}{
  int page;
  int totalPage;
  List<{{name.pascalCase()}}> {{name.camelCase()}}s;

  Paginated{{name.pascalCase()}}({
    required this.page,
    required this.totalPage,
    required this.{{name.camelCase()}}s,
  });

}


}