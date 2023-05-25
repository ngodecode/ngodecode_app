import 'package:flutter/material.dart';
import 'common_route.dart';

abstract class CommonRouteNavigator {

  void navigateTo(BuildContext context, String uri);
  void pop(BuildContext context, [Object? result]);

}


