import 'package:common_di/common_di.dart';
import 'package:common_router/common_router.dart';
import 'package:common_router_go_router/common_router_go_router.dart';
import 'package:ngodecode_app/route/routes.dart';

class GoRouterRegistrar extends Registrar {
  GoRouterRegistrar(this._routes);

  final Routes _routes;

  @override
  void onRegister(Registry registry) {
    registry.registerSingleton<CommonRouteBuilder>(
        GoRouterBuilder(initialRoute: _routes.home)
    );
    registry.registerFactory<CommonRouteNavigator>(() => GoRouterNavigator());
  }
}
