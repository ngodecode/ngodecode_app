import 'package:common_router/common_router.dart';
import 'package:flutter/material.dart';
import 'package:common_di/common_di.dart';
import 'package:common_di_get_it/common_di_get_it.dart';
import 'package:ngodecode_app/config/config.dart';
import 'package:ngodecode_app/route/navigation/payment_navigation_impl.dart';
import 'package:ngodecode_app/route/navigation/product_navigation_impl.dart';
import 'package:ngodecode_app/route/routes.dart';
import 'package:payment_feature/payment_feature.dart';
import 'package:product_feature/product_feature.dart';
import 'package:common_ui/common_style.dart';
import 'route/route_registrar.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  final routes = Routes();
  DependencyInjection.build(
    registry: GetItRegistry(),
    registrars: [
      GoRouterRegistrar(routes),
      ProductFeatureRegistrar(
        baseUrl: NetworkConfig.getUrl("product_api"),
        route: routes,
        navigation: (navigator) => ProductNavigationImpl(navigator, routes),
      ),
      PaymentFeatureRegistrar(
        baseUrl: NetworkConfig.getUrl("payment_api"),
        route: routes,
        navigation: (navigator) => PaymentNavigationImpl(navigator, routes),
      ),
    ],
  );

  setPathUrlStrategy();
  runApp(MainApp());
}

class MainApp extends StatelessWidget with Injectable {
  MainApp({super.key});

  late final RouterConfig<Object> _router =
      inject<CommonRouteBuilder>().build();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: CommonTypography.textButton,
          toolbarTextStyle: CommonTypography.textButton,
        ),
      ),
    );
  }
}
