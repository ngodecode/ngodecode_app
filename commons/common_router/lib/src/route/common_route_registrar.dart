import 'dart:collection';

import 'package:flutter/material.dart';
import 'common_route.dart';

abstract class CommonRouteBuilder<T extends RouterConfig<Object>> {
  final Map<String, RouteWidgetBuilder> _routeMap = HashMap();
  final Map<String, RouteWidgetBuilder> _routeDialogMap = HashMap();
  final Map<String, Redirection> _redirectionMap = HashMap();

  T onBuildConfig(Map<String, CommonRoute> routes);

  void register(Map<String, RouteWidgetBuilder> map) {
    _routeMap.addAll(map);
  }

  void registerDialog(Map<String, RouteWidgetBuilder> map) {
    _routeDialogMap.addAll(map);
  }

  void redirect(Map<String, Redirection> map) {
    _redirectionMap.addAll(map);
  }

  T build() {
    return onBuildConfig(
      _routeMap.map(
        (key, value) => MapEntry(
          key,
          CommonRoute(
            key,
            builder: value,
            redirection: _redirectionMap.remove(key),
          ),
        ),
      )..addAll(
          _routeDialogMap.map(
            (key, value) => MapEntry(
              key,
              CommonRoute(
                key,
                builder: value,
                redirection: _redirectionMap.remove(key),
                isDialog: true,
              ),
            ),
          ),
        ),
    );
  }
}
