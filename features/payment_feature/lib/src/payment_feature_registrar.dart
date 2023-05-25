import 'package:common_di/common_di.dart';
import 'package:common_network_dio/common_network_dio.dart';
import 'package:common_router/common_router.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:common_ui/number_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:payment_domain/payment_domain.dart';
import 'package:payment_data/payment_data.dart';
import 'package:payment_data/payment_data_impl.dart';
import 'package:payment_feature/src/payment_feature_route_path.dart';
import 'package:payment_ui/payment_ui.dart';

class PaymentFeatureRegistrar extends Registrar {
  PaymentFeatureRegistrar({
    required this.route,
    required this.baseUrl,
    required this.navigation,
  });

  PaymentFeatureRoutePath route;
  String baseUrl;
  PaymentNavigation Function(CommonRouteNavigator navigator) navigation;

  @override
  void onRegister(Registry registry) {
    registry.registerFactory(() => navigation);
    registry.registerFactory(
      () => PaymentApi(DioRestClient(baseUrl)),
    );
    registry.registerFactory<InvoiceDataSource>(
      () => InvoiceDataSourceImpl(registry()),
    );
    registry.registerFactory<InvoiceRepository>(
      () => InvoiceRepositoryImpl(registry()),
    );
    registry.registerFactory(() => CreateInvoiceUseCase(registry()));
    registry.registerFactory(() => SendInvoiceMailUseCase(registry()));
    registry.registerFactory(() => GetInvoiceDetailUseCase(registry()));

    _routeRegister(registry(), route);
  }

  void _routeRegister(
    CommonRouteBuilder builder,
    PaymentFeatureRoutePath route,
  ) {
    builder.register({
      route.invoiceDetail: (navigation) {
        final arguments = navigation.query ?? {};
        return InvoiceDetailPage(
          invoiceId: arguments["invoiceId"].orEmpty(),
        );
      },
    });

    builder.registerDialog({
      route.payment: (navigation) {
        final arguments = navigation.query ?? {};
        return const SizedBox();
      },
    });
  }
}
