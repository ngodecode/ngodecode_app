import '../../../common_di.dart';

mixin Injectable {

  T inject<T extends Object>() => DependencyInjection.registry();

}