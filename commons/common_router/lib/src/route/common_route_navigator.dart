import 'package:flutter/material.dart';

abstract class CommonRouteNavigator {

  void navigateTo(BuildContext context, String uri);
  void pop(BuildContext context, [Object? result]);

}


