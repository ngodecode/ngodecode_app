import 'package:flutter/foundation.dart';

class NetworkConfig {
  static const _releaseUrls = {
    "product_api": "http://localhost/api",
    "payment_api": "http://localhost/api",
  };

  static const _debugUrls = {
    "product_api": "http://localhost/api",
    "payment_api": "http://localhost/api",
  };

  static String getUrl(String name) =>
      (kReleaseMode ? _releaseUrls[name] : _debugUrls[name]) ?? "";
}
