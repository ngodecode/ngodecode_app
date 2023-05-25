import 'package:flutter/material.dart';

typedef RouteWidgetBuilder<T extends Widget> = T Function(RouteNavigation);

typedef Redirection = RouteNavigation? Function(RouteNavigation);

class RouteNavigation {
  RouteNavigation(this.path, {this.params, this.query});

  String path;
  Map<String, String>? params;
  Map<String, String>? query;
}

class CommonRoute {
  CommonRoute(
    this.path, {
    required this.builder,
    this.redirection,
    this.isDialog,
  });

  final String path;
  final RouteWidgetBuilder builder;
  final Redirection? redirection;
  final bool? isDialog;
}
