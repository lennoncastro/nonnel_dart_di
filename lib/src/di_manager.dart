import 'errors/invalid_dependency_name.error.dart';
import 'errors/not_declared_dependency.error.dart';
import 'models/dependency.dart';

mixin DIManager {
  static final Map<String, Dependency> _declaredDependencies =
      <String, Dependency>{};

  static final Map<String, Dependency> _singletonDeclaredDependencies =
      <String, Dependency>{};

  static void factory<T extends Object>(
    T instance, {
    String? named,
    bool isSingleton = false,
  }) {
    _validatedNamed(named);
    final String key = named ?? T.toString();
    final Dependency dependency = Dependency(
      builder: () => instance,
      isSingleton: false,
    );
    _declaredDependencies.addAll(<String, Dependency>{key: dependency});
  }

  static void singleton<T extends Object>(
    T instance, {
    String? named,
  }) {
    _validatedNamed(named);
    final String key = named ?? T.toString();
    final Dependency dependency = Dependency(
      builder: () => instance,
      isSingleton: true,
    );
    final Dependency? singletonInstance = _singletonDeclaredDependencies[key];
    if (singletonInstance == null) {
      _singletonDeclaredDependencies
          .addAll(<String, Dependency>{key: dependency});
    }
  }

  static void lazyFactory<T extends Object>(
    Object Function() builder, {
    String? named,
    bool isSingleton = false,
  }) {
    _validatedNamed(named);
    final String key = named ?? T.toString();
    final Dependency dependency = Dependency(
      builder: builder,
      isSingleton: isSingleton,
    );
    _declaredDependencies.addAll(<String, Dependency>{key: dependency});
  }

  static T inject<T extends Object>({
    String? named,
  }) {
    final String key = named ?? T.toString();
    final Dependency? singletonDependency = _singletonDeclaredDependencies[key];
    if (singletonDependency != null) {
      return (singletonDependency.builder()) as T;
    }
    final Dependency? dependency = _declaredDependencies[key];
    if (dependency != null) {
      return (dependency.builder()) as T;
    }
    throw NotDeclaredDependencyError();
  }

  static clearDependencies() => _declaredDependencies.clear();

  static void _validatedNamed(String? named) {
    if (named != null && named.isEmpty) throw InvalidDependencyNameError();
  }
}
