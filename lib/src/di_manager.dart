import 'models/dependency_id.dart';
import 'errors/not_declared_dependency.error.dart';

mixin DIManager {
  static final Map<DependencyID, Object Function()> _dependencies =
      <DependencyID, Object Function()>{};

  static void factory<T extends Object>(
    T instance, {
    String? named,
  }) {
    final DependencyID dependencyID = DependencyID(
      typeName: T.toString(),
      named: named,
    );
    _dependencies.addAll(<DependencyID, Object Function()>{
      dependencyID: () => instance,
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
    _dependencies.addAll(<DependencyID, Object Function()>{
      dependencyID: builder,
    });
  }

  static T inject<T extends Object>({
    String? named,
  }) {
    final String typeName = T.toString();
    final Iterable<DependencyID> dependencyIDList = _dependencies.keys.where(
        (element) =>
            element.typeName != null && element.typeName == typeName ||
            element.named != null && element.named == named);

    if (dependencyIDList.isEmpty) {
      throw NotDeclaredDependencyError();
    }

    final first = _dependencies.entries
        .where((element) =>
            element.key.typeName != null && element.key.typeName == typeName ||
            element.key.named != null && element.key.named == named)
        .first
        .value();

    return first as T;
  }

  static clearDependencies() {
    _dependencies.clear();
    print(_dependencies.toString());
  }
}
