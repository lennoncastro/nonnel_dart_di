import 'models/dependency.dart';
import 'models/dependency_id.dart';
import 'errors/not_declared_dependency.error.dart';

mixin DIManager {
  static final Map<Dependency, Object Function()> _dependencies =
      <Dependency, Object Function()>{};

  static void factory<T extends Object>(
    T instance, {
    String? named,
  }) {
    final DependencyID dependencyID = DependencyID(
      typeName: T.toString(),
      named: named,
    );
    final Dependency dependency = Dependency(
      dependencyID: dependencyID,
      isSingleton: false,
    );
    _dependencies.addAll(<Dependency, Object Function()>{
      dependency: () => instance,
    });
  }

  static void lazyFactory<T extends Object>(
    Object Function() builder, {
    String? named,
  }) {
    final DependencyID dependencyID = DependencyID(
      typeName: T.toString(),
      named: named,
    );
    final Dependency dependency = Dependency(
      dependencyID: dependencyID,
      isSingleton: false,
    );
    _dependencies.addAll(<Dependency, Object Function()>{
      dependency: builder,
    });
  }

  static T inject<T extends Object>({
    String? named,
  }) {
    final String typeName = T.toString();
    final Iterable<MapEntry<Dependency, Object Function()>> dependencies =
        _dependencies.entries.where((element) =>
            element.key.dependencyID.typeName != null &&
                element.key.dependencyID.typeName == typeName ||
            element.key.dependencyID.named != null &&
                element.key.dependencyID.named == named);

    if (dependencies.isEmpty) {
      throw NotDeclaredDependencyError();
    }
    return dependencies.first.value() as T;
  }

  static clearDependencies() => _dependencies.clear();
}
