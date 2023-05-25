import 'registrar/registrar.dart';
import 'registrar/registry.dart';

class DependencyInjection {
  static late Registry _registry;

  static void build({
    required Registry registry,
    required List<Registrar> registrars,
  }) {
    _registry = registry;
    for (var registrar in registrars) {
      registrar.onRegister(registry);
    }
  }

  static Registry get registry => _registry;
}
