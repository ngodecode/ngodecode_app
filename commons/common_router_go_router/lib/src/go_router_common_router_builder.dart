import 'package:flutter/material.dart';
import 'package:common_router/common_router.dart';
import 'package:common_ui/common_page.dart';
import 'package:go_router/go_router.dart';

class GoRouterNavigator implements CommonRouteNavigator {
  @override
  void navigateTo(BuildContext context, String uri) {
    context.go(uri);
  }

  @override
  void pop(BuildContext context, [Object? result]) {
    context.pop();
  }
}

class GoRouterBuilder extends CommonRouteBuilder<GoRouter> {
  GoRouterBuilder({required this.initialRoute});

  final String initialRoute;

  @override
  GoRouter onBuildConfig(Map<String, CommonRoute> routes) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: <RouteBase>[
        ...routes.values
            .map(
              (route) {
                if (route.isDialog == true) {
                  return GoRoute(
                    path: route.path,
                    pageBuilder: (context, state) => PageDialog(
                      builder: (context) => route.builder(
                        RouteNavigation(
                          state.path ?? "",
                          params: state.params,
                          query: state.queryParams,
                        ),
                      ),
                    ),
                  );
                }
                return GoRoute(
                  path: route.path,
                  builder: (context, state) => route.builder(
                    RouteNavigation(
                      state.path ?? "",
                      params: state.params,
                      query: state.queryParams,
                    ),
                  ),
                );
              },
        ).toList()
      ],
      redirect: (context, state) {
        final redirection = routes[state.path]?.redirection;
        if (redirection == null) {
          return null;
        }
        final navigation = redirection(
          RouteNavigation(
            state.path ?? "",
            params: state.params,
            query: state.queryParams,
          ),
        );
        if (navigation == null) {
          return null;
        }
        return Uri(
          path: navigation.path,
          queryParameters: navigation.query,
        ).toString();
      },
    );
  }
}
