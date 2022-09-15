import 'errors/invalid_dependency_name.error.dart';
import 'errors/not_declared_dependency.error.dart';
import 'models/dependency.dart';

mixin DIManager {
  static final List<String> _logs = <String>[];
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
    _logs.add('🛠  factory $key');
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
    _logs.add('🛠  singleton $key');
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
    _logs.add('🛠  lazyFactory $key');
  }

  static T inject<T extends Object>({
    String? named,
  }) {
    final String key = named ?? T.toString();
    final Dependency? singletonDependency = _singletonDeclaredDependencies[key];
    _logs.add('  💉 $key');
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

  static logs() {
    final StringBuffer logs = StringBuffer('\nD.I Manager log\n');
    logs.write('\nOperations: ${_logs.length}\n\n');
    logs.write(
        ' - Factories total: ${_logs.where((element) => element.contains('factory')).length}\n');
    logs.write(
        ' - Lazy factories total: ${_logs.where((element) => element.contains('lazyFactory')).length}\n');
    logs.write(
        ' - Singletons total: ${_logs.where((element) => element.contains('singleton')).length}\n');
    logs.write(
        ' - Injects total: ${_logs.where((element) => element.contains('inject')).length}\n');
    logs.write('\nExecution: \n');
    for (final String log in _logs) {
      logs.write('\n$log\n');
    }
    logs.write('\nEnd D.I Manager log\n');
    return logs.toString();
  }

  static void _validatedNamed(String? named) {
    if (named != null && named.isEmpty) throw InvalidDependencyNameError();
  }
}
