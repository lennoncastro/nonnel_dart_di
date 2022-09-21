import 'package:nonnel/src/models/log.dart';

import 'di_logger.dart';
import 'models/dependency.dart';

mixin DIManager {
  static final Map<String, Dependency> _factories = <String, Dependency>{};

  static final Map<String, Dependency> _singletons = <String, Dependency>{};

  static void factory<T extends Object>(T instance, {String? named}) {
    _validateNamed(named);
    final String key = named ?? T.toString();
    final Dependency dependency = Dependency.createDependency(
      () => instance,
      false,
    );
    _factories.addAll(<String, Dependency>{key: dependency});
    DILogger.add(Log(name: key, type: 'factory'));
    if (DILogger.showLogs) print(DILogger.showLast());
  }

  static void singleton<T extends Object>(T instance, {String? named}) {
    _validateNamed(named);
    final String key = named ?? T.toString();
    final Dependency dependency = Dependency.createDependency(
      () => instance,
      true,
    );
    final Dependency? singletonInstance = _singletons[key];
    if (singletonInstance == null) {
      _singletons.addAll(<String, Dependency>{key: dependency});
    }
    DILogger.add(Log(name: key, type: 'singleton'));
    if (DILogger.showLogs) print(DILogger.showLast());
  }

  static void lazyFactory<T extends Object>(
    T Function() builder, {
    String? named,
  }) {
    _validateNamed(named);
    final String key = named ?? T.toString();
    Dependency dependency = Dependency.createDependency(builder, false);
    _factories.addAll(<String, Dependency>{key: dependency});
    DILogger.add(Log(name: key, type: 'lazyFactory'));
    if (DILogger.showLogs) print(DILogger.showLast());
  }

  static T inject<T extends Object>({String? named}) {
    final String key = named ?? T.toString();
    final Dependency? singleton = _singletons[key];
    if (singleton != null) {
      DILogger.add(Log(name: key, type: 'inject'));
      return getDependency<T>(singleton);
    }
    final Dependency? factory = _factories[key];
    if (factory != null) {
      DILogger.add(Log(name: key, type: 'inject'));
      return getDependency<T>(factory);
    }
    throw 'Not declared dependency: $key';
  }

  static T getDependency<T extends Object>(Dependency dependency) {
    if (DILogger.showLogs) print(DILogger.showLast());
    return WeakReference<T>(dependency.builder() as T).target as T;
  }

  static reset() => _factories.clear();

  static void _validateNamed(String? named) {
    if (named != null && named.isEmpty) {
      throw 'Invalid dependency name error: $named';
    }
  }
}
