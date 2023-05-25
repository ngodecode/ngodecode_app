import 'package:common_di/common_di.dart';
import 'package:common_network_dio/common_network_dio.dart';
import 'package:common_router/common_router.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_data/product_data.dart';
import 'package:product_data/product_data_impl.dart';
import 'package:product_ui/product_ui.dart';
import 'product_feature_route_path.dart';

class ProductFeatureRegistrar extends Registrar {
  ProductFeatureRegistrar({
    required this.route,
    required this.baseUrl,
    required this.navigation,
  });

  ProductFeatureRoutePath route;
  ProductNavigation Function(CommonRouteNavigator navigator) navigation;
  String baseUrl;

  @override
  void onRegister(Registry registry) {
    registry.registerFactory(
      () => navigation(registry()),
    );
    registry.registerFactory(
      () => ProductApi(DioRestClient(baseUrl)),
    );
    registry.registerFactory<ProductDataSource>(
      () => ProductDataSourceImpl(registry()),
    );
    registry.registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(registry()),
    );
    registry.registerFactory(() => GetProductUseCase(registry()));
    registry.registerFactory(() => GetProductPaginatedUseCase(registry()));

    _routeRegister(registry(), route);
  }

  void _routeRegister(
    CommonRouteBuilder builder,
    ProductFeatureRoutePath path,
  ) {
    builder.register({
      path.product: (navigation) => ProductListPage(
            keyword: navigation.query?["keyword"],
          ),
      path.productDetail: (navigation) {
        final arguments = navigation.params ?? {};
        return ProductDetailPage(
          productId: arguments["productId"].orEmpty(),
        );
      },
    });
  }
}
