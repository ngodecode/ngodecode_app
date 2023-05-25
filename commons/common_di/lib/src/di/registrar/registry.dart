
abstract class Registry {

  void registerSingleton<T extends Object>(T instance, {String? name});

  void registerLazySingleton<T extends Object>(T Function() factory, {String? name});

  void registerFactory<T extends Object>(T Function() factory, {String? name});

  T call<T extends Object>({String? name});

}

