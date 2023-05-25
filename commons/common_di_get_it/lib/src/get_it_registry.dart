import 'package:common_di/common_di.dart';
import 'package:get_it/get_it.dart';

class GetItRegistry extends Registry {

  @override
  void registerFactory<T extends Object>(T Function() factory, {String? name}) {
    GetIt.instance.registerFactory(factory, instanceName: name);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory, {String? name}) {
    GetIt.instance.registerLazySingleton(factory, instanceName: name);
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? name}) {
    GetIt.instance.registerSingleton(instance, instanceName: name);
  }

  @override
  T call<T extends Object>({String? name}) {
    return GetIt.instance.get(instanceName: name);
  }

}